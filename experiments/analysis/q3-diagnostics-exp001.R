# EXPLORATORY DIAGNOSTICS -- NOT a frozen surface, NOT registered evidence.
# Yen's Q3 local-dependence diagnostics accompanying the M4 benchmark report,
# computed for exp_2026_08_02_001 (much_tte_2025_matrixreasoning).
#
# Design: fit the 2PL baseline on the train fold (complete cases, exactly as
# the frozen evaluator does), then compute residuals e_ij = y_ij - P_j(EAP_i)
# on the HELD-OUT test fold and correlate them across item pairs. Held-out
# residuals avoid the extra overfitting-induced negative bias of same-sample
# Q3; the usual small negative reference value E[Q3] ~ -1/(J-1) still applies.
#
# Also refits the best pre-registered copula family (rjoe) on the train fold
# and records its per-item dependence parameters and Kendall's taus -- the
# copula's account of the dependence the 2PL leaves in the residuals.
#
# Outputs (committed):
#   experiments/analysis/q3-exp001.csv             item_i, item_j, q3
#   experiments/analysis/q3-exp001-summary.csv     summary statistics
#   experiments/analysis/rjoe-estimates-exp001.csv item, theta, tau, cut1

suppressMessages({
  library(yaml)
  devtools::load_all("packages/r-packages/irtc", quiet = TRUE)
})

manifest <- yaml::read_yaml("data/manifests/datasets.yaml")$datasets
splits <- yaml::read_yaml("data/manifests/splits.yaml")$splits
ds <- Filter(function(d) identical(d$dataset_id, "much_tte_2025_matrixreasoning"), manifest)[[1]]
sp <- Filter(function(s) identical(s$split_id, "much_tte_2025_matrixreasoning_p80"), splits)[[1]]

sha256 <- function(path) as.character(tools::sha256sum(path))
stopifnot(
  sha256(ds$gold) == ds$gold_hash,
  sha256(sp$file) == sp$file_hash
)

gold <- utils::read.csv(ds$gold)
resp <- as.matrix(gold[, -1])
storage.mode(resp) <- "integer"
fold <- utils::read.csv(sp$file)$fold

train <- resp[fold == "train", , drop = FALSE]
test <- resp[fold == "test", , drop = FALSE]
train_cc <- train[stats::complete.cases(train), , drop = FALSE]

fit <- fit_baseline(train_cc, model = "2pl")
a <- fit$estimates$a
b <- fit$estimates$b

# EAP ability for each test person under the training-time 2PL parameters
# (61-point normal quadrature, matching the evaluator's marginal path).
gq <- statmod::gauss.quad.prob(61, dist = "normal", mu = 0, sigma = 1)
p_nodes <- stats::plogis(outer(gq$nodes, b, `-`) * rep(a, each = 61))  # Q x J
p_nodes <- pmin(pmax(p_nodes, 1e-300), 1 - 1e-16)
y1 <- test; y1[is.na(y1)] <- 0L
y0 <- 1L - test; y0[is.na(y0)] <- 0L
ll_nq <- y1 %*% t(log(p_nodes)) + y0 %*% t(log1p(-p_nodes))            # N x Q
m <- apply(ll_nq, 1, max)
post <- exp(ll_nq - m) * rep(gq$weights, each = nrow(test))
eap <- as.numeric((post %*% gq$nodes) / rowSums(post))

# Residuals and Q3 on the test fold.
p_hat <- stats::plogis(outer(eap, b, `-`) * rep(a, each = length(eap)))  # N x J
resid <- test - p_hat
q3 <- stats::cor(resid, use = "pairwise.complete.obs")

items <- fit$estimates$item
pairs <- which(upper.tri(q3), arr.ind = TRUE)
q3_long <- data.frame(
  item_i = items[pairs[, 1]],
  item_j = items[pairs[, 2]],
  q3 = round(q3[pairs], 6)
)
q3_long <- q3_long[order(-abs(q3_long$q3)), ]
utils::write.csv(q3_long, "experiments/analysis/q3-exp001.csv", row.names = FALSE)

n_pairs <- nrow(q3_long)
summary_df <- data.frame(
  statistic = c(
    "n_test_persons", "n_items", "n_pairs",
    "q3_mean", "q3_reference_neg_1_over_Jm1",
    "q3_max", "q3_min", "n_pairs_abs_above_0.2"
  ),
  value = round(c(
    nrow(test), length(items), n_pairs,
    mean(q3_long$q3), -1 / (length(items) - 1),
    max(q3_long$q3), min(q3_long$q3), sum(abs(q3_long$q3) > 0.2)
  ), 6)
)
utils::write.csv(summary_df, "experiments/analysis/q3-exp001-summary.csv", row.names = FALSE)

# The rjoe account of the same dependence (train-fold refit, seeded by
# determinism of the two-stage estimator -- no RNG involved).
rjoe <- fit_copula_1f(train_cc, family = "rjoe", nq = 25)
utils::write.csv(
  data.frame(
    item = rjoe$estimates$item,
    theta = round(rjoe$estimates$theta, 4),
    tau = round(rjoe$estimates$tau, 4),
    cut1 = round(rjoe$estimates$cut1, 4)
  ),
  "experiments/analysis/rjoe-estimates-exp001.csv",
  row.names = FALSE
)

message(sprintf(
  "Q3: mean %.4f (ref %.4f), range [%.4f, %.4f], %d/%d pairs |Q3| > 0.2",
  mean(q3_long$q3), -1 / (length(items) - 1),
  min(q3_long$q3), max(q3_long$q3),
  sum(abs(q3_long$q3) > 0.2), n_pairs
))
message("rjoe theta range: [",
        round(min(rjoe$estimates$theta), 3), ", ",
        round(max(rjoe$estimates$theta), 3), "]; tau range: [",
        round(min(rjoe$estimates$tau), 3), ", ",
        round(max(rjoe$estimates$tau), 3), "]")
