# M3 ingestion: tier-A and tier-B IRW datasets through the WP4 zones.
# Run from the repo root: Rscript data/ingest-m3.R
# Raw longs land in data/raw/ (gitignored, hashed); benchmark-ready wide
# matrices + fixed person-level splits land in data/gold/ (committed).
suppressMessages(library(irw))

sha256 <- function(path) as.character(tools::sha256sum(path))

ingest <- function(table_id, split_seed) {
  message("== ", table_id, " ==")
  long <- as.data.frame(irw_fetch(table_id))
  raw_path <- file.path("data/raw", paste0(table_id, "_long.csv"))
  utils::write.csv(long, raw_path, row.names = FALSE)

  wide <- irw_long2resp(long)
  id_col <- if ("id" %in% names(wide)) "id" else names(wide)[1]
  resp <- as.matrix(wide[, setdiff(names(wide), id_col)])
  storage.mode(resp) <- "integer"

  gold_path <- file.path("data/gold", paste0(table_id, "_resp.csv"))
  utils::write.csv(cbind(person = wide[[id_col]], as.data.frame(resp)),
                   gold_path, row.names = FALSE)

  set.seed(split_seed)
  n <- nrow(resp)
  test_idx <- sort(sample.int(n, size = round(0.2 * n)))
  split_path <- file.path("data/gold", paste0(table_id, "_split.csv"))
  utils::write.csv(
    data.frame(row = seq_len(n),
               fold = ifelse(seq_len(n) %in% test_idx, "test", "train")),
    split_path, row.names = FALSE)

  cat(sprintf(
    "%s: n_persons=%d n_items=%d values=[%s] missing=%.4f\n  raw_hash=%s\n  gold_hash=%s\n  split_hash=%s\n",
    table_id, nrow(resp), ncol(resp),
    paste(sort(unique(as.vector(resp[!is.na(resp)]))), collapse = ","),
    mean(is.na(resp)), sha256(raw_path), sha256(gold_path), sha256(split_path)))
}

ingest("much_tte_2025_matrixreasoning", split_seed = 20260801)
ingest("tma", split_seed = 20260802)

irw_save_bibtex(
  c("much_tte_2025_matrixreasoning", "tma", "enem_2019_1mil_lc"),
  output_file = "research/literature/irw-datasets.bib"
)
message("bibtex written")
