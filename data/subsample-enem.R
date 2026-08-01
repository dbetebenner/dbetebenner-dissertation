# Execute data/enem-subsampling-plan.md (frozen 2026-08-01, commit 3a673bb).
# Run from repo root: Rscript data/subsample-enem.R
# Full table is fetched transiently; only the two subsampled longs persist.
suppressMessages({library(irw); library(data.table)})

sha256 <- function(path) as.character(tools::sha256sum(path))

message("fetching enem_2019_1mil_lc (transient)...")
long <- as.data.table(irw_fetch("enem_2019_1mil_lc"))
message("rows: ", nrow(long), "  persons: ", uniqueN(long$id))

# Person -> booklet frame with deterministic ordering (plan: sort ids
# lexicographically before any draw).
persons <- unique(long[, .(id, booklet)])
setorder(persons, id)

draw <- function(n_target, seed) {
  set.seed(seed)
  # Proportional allocation by booklet, largest-remainder rounding.
  tab <- persons[, .N, by = booklet][order(booklet)]
  alloc <- floor(tab$N / sum(tab$N) * n_target)
  rem <- n_target - sum(alloc)
  frac <- (tab$N / sum(tab$N) * n_target) - alloc
  alloc[order(-frac)[seq_len(rem)]] <- alloc[order(-frac)[seq_len(rem)]] + 1
  out <- vector("list", nrow(tab))
  for (k in seq_len(nrow(tab))) {
    ids_k <- persons[booklet == tab$booklet[k], id]  # already id-sorted
    out[[k]] <- ids_k[sample.int(length(ids_k), alloc[k])]
  }
  sort(unlist(out))
}

persist <- function(sub_id, ids) {
  sub <- long[id %in% ids]
  raw_path <- file.path("data/raw", paste0(sub_id, "_long.csv"))
  fwrite(sub, raw_path)
  wide <- irw_long2resp(as.data.frame(sub))
  id_col <- if ("id" %in% names(wide)) "id" else names(wide)[1]
  resp <- as.matrix(wide[, setdiff(names(wide), id_col)])
  storage.mode(resp) <- "integer"
  gold_path <- file.path("data/gold", paste0(sub_id, "_resp.csv"))
  fwrite(cbind(data.table(person = wide[[id_col]]), as.data.table(resp)), gold_path)
  cat(sprintf("%s: persons=%d items=%d missing=%.5f\n  raw_hash=%s\n  gold_hash=%s\n",
              sub_id, nrow(resp), ncol(resp), mean(is.na(resp)),
              sha256(raw_path), sha256(gold_path)))
  invisible(nrow(resp))
}

bench_ids <- draw(10000, 20260804)
stress_ids <- draw(100000, 20260805)
n_bench <- persist("enem19lc_bench10k", bench_ids)
persist("enem19lc_stress100k", stress_ids)

# Split for the benchmark subsample only (plan: person 80/20, seed 20260806).
set.seed(20260806)
test_idx <- sort(sample.int(n_bench, size = round(0.2 * n_bench)))
split_path <- "data/gold/enem19lc_bench10k_split.csv"
fwrite(data.table(row = seq_len(n_bench),
                  fold = ifelse(seq_len(n_bench) %in% test_idx, "test", "train")),
       split_path)
cat("split_hash=", sha256(split_path), "\n", sep = "")
message("done")
