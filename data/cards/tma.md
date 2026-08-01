---
dataset_id: tma
source_name: "Taylor Manifest Anxiety Scale (Taylor 1953) via openpsychometrics.org — IRW core v43.0"
source_url: "https://stanford.redivis.com/datasets/as2e-cv7jb41fd/tables/hd62-026kwagr9?v=43.0"
irw_version: "v43.0"
license: "CC BY 4.0"
provenance_summary: >-
  Classic 50-item true/false anxiety scale (DOI 10.1037/h0056264 for the
  instrument); responses collected by openpsychometrics.org
  (https://openpsychometrics.org/_rawdata/); harmonized by IRW. Fetched via
  irw::irw_fetch 2026-08-01.
construct: "Manifest anxiety (affective/mental health)"
response_type: dichotomous
n_persons: 5399
n_items: 50
n_responses: 267878
missingness_rate: 0.0077
scoring_rules: "resp is IRW-harmonized 0/1 (true/false keyed)"
item_group_variables: []
known_limitations:
  - "Self-selected internet sample; clinical/targeted tag in IRW"
  - "Instrument citation (1953) predates this data collection; collection date not in IRW metadata"
preprocessing_steps:
  - "irw_fetch -> irw_long2resp"
  - "11 of 5410 ids dropped by irw density threshold (0.1)"
raw_hash: "37b203822f1b57803804b1364db6dde7d6b1a1ea83a81f70126188938aaf4b36"
silver_hash: null
gold_hash: "b9e6ea87cec496f23262d0e8f58a31cbd00c1036f06b838eb84cdc0181644966"
created_at: 2026-08-01
created_by: claude-fable-5-m3
---

# tma — Tier B (primary benchmark)

The Taylor Manifest Anxiety Scale: 50 dichotomous items, n=5,399, near-complete.
Selected as the first primary benchmark — large enough for fair
IRTc-vs-baseline comparison, a classic instrument with decades of psychometric
context, clean license. Affective construct complements the Tier-A cognitive
one; an educational Tier-B (with suspected local dependence) arrives with the
ENEM subsampling at M4.
