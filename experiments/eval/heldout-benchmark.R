# FROZEN EVALUATION SCRIPT (charter 11.2: frozen surfaces).
# Registered experiments list this file in frozen_files; once a run is
# `planned` or `running`, edits here invalidate the run.
#
# Usage: Rscript experiments/eval/heldout-benchmark.R <run_id>
#
# Contract:
#   - Verifies the gold-data and split hashes against the manifests before
#     touching a single response (integrity gate).
#   - Fits every model in the registry entry on the TRAIN fold
#     (complete cases only, as declared in each entry's preprocessing note),
#     then computes the PRIMARY metric -- held-out marginal log-loss per
#     response (irtc::heldout_logloss) -- on the FULL test fold (missing
#     responses skipped by the evaluator, never imputed).
#   - Writes experiments/runs/<run_id>/metrics.json and a plain-text log.
#   - Never prints a superiority verdict: acceptance thresholds are applied
#     at claim-audit time against the recorded numbers, not here.

suppressMessages({
  library(yaml)
  devtools::load_all("packages/r-packages/irtc", quiet = TRUE)
})

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 1) stop("usage: heldout-benchmark.R <run_id>")
run_id <- args[[1]]

registry <- yaml::read_yaml("experiments/registry.yaml")$experiments
entry <- Filter(function(e) identical(e$run_id, run_id), registry)
if (length(entry) != 1) stop("run_id not found (or duplicated) in registry: ", run_id)
entry <- entry[[1]]

manifest <- yaml::read_yaml("data/manifests/datasets.yaml")$datasets
splits <- yaml::read_yaml("data/manifests/splits.yaml")$splits
ds <- Filter(function(d) identical(d$dataset_id, entry$dataset_id), manifest)[[1]]
sp <- Filter(function(s) identical(s$split_id, entry$split_id), splits)[[1]]

sha256 <- function(path) as.character(tools::sha256sum(path))
stopifnot(
  "gold hash mismatch -- data integrity gate failed" =
    sha256(ds$gold) == ds$gold_hash,
  "split hash mismatch -- split integrity gate failed" =
    sha256(sp$file) == sp$file_hash
)

gold <- utils::read.csv(ds$gold)
resp <- as.matrix(gold[, -1])
storage.mode(resp) <- "integer"
fold <- utils::read.csv(sp$file)$fold
stopifnot(length(fold) == nrow(resp))

train <- resp[fold == "train", , drop = FALSE]
test <- resp[fold == "test", , drop = FALSE]
train_cc <- train[stats::complete.cases(train), , drop = FALSE]

message(sprintf(
  "%s: train %d (cc %d) / test %d persons x %d items",
  run_id, nrow(train), nrow(train_cc), nrow(test), ncol(resp)
))

fit_model <- function(model_id) {
  if (model_id == "baseline_2pl_mirt") {
    fit <- fit_baseline(train_cc, model = "2pl")
    ev <- heldout_logloss(fit, test, nq = 61)
  } else if (grepl("^irtc_1f_", model_id)) {
    fam <- sub("^irtc_1f_", "", model_id)
    fit <- fit_copula_1f(train_cc, family = fam, nq = 25)
    ev <- heldout_logloss(fit, test, nq = 25)
  } else {
    stop("unknown model id: ", model_id)
  }
  list(
    model_id = model_id,
    model = fit$model,
    engine = sprintf("%s %s", fit$engine, fit$engine_version),
    converged = fit$converged,
    n_parameters = fit$n_parameters,
    train_loglik = fit$log_likelihood,
    train_aic = -2 * fit$log_likelihood + 2 * fit$n_parameters,
    runtime_seconds = round(fit$runtime_seconds, 2),
    heldout_total_loglik = ev$total_loglik,
    heldout_n_responses = ev$n_responses,
    heldout_logloss_per_response = ev$logloss_per_response,
    n_warnings = length(fit$warnings)
  )
}

results <- list()
for (m in entry$models) {
  message("fitting ", m, " ...")
  t0 <- proc.time()[["elapsed"]]
  results[[m]] <- tryCatch(
    fit_model(m),
    error = function(e) list(model_id = m, error = conditionMessage(e))
  )
  message(sprintf("  done in %.1fs", proc.time()[["elapsed"]] - t0))
}

out_dir <- file.path("experiments/runs", run_id)
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
jsonlite::write_json(
  list(
    run_id = run_id,
    dataset_id = entry$dataset_id,
    split_id = entry$split_id,
    gold_hash = ds$gold_hash,
    split_hash = sp$file_hash,
    eval_script = "experiments/eval/heldout-benchmark.R",
    results = unname(results)
  ),
  file.path(out_dir, "metrics.json"),
  auto_unbox = TRUE, digits = NA, pretty = TRUE
)
message("wrote ", file.path(out_dir, "metrics.json"))
