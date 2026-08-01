---
dataset_id: much_tte_2025_matrixreasoning
source_name: "Much, Mutak, Pohl & Ranger (2025), Journal of Open Psychology Data 13(1) — IRW core v43.0"
source_url: "https://stanford.redivis.com/datasets/as2e-cv7jb41fd/tables/sh2w-bag38n8ds?v=43.0"
irw_version: "v43.0"
license: "CC BY 4.0"
provenance_summary: >-
  Validation study of two psychometric models on test-taking behavior; figural
  matrix-reasoning items. Original data at OSF (https://osf.io/9j6hm/), DOI
  10.5334/jopd.124; harmonized by IRW. Fetched via irw::irw_fetch 2026-08-01.
construct: "Abstract reasoning (figural pattern completion)"
response_type: dichotomous
n_persons: 1243
n_items: 10
n_responses: 12386
missingness_rate: 0.0035
scoring_rules: "resp is IRW-scored 0/1 correctness of raw_resp"
item_group_variables: []
known_limitations:
  - "Longitudinal source: irw_long2resp kept wave 1 only (most frequent), reducing 20 metadata items to 10 analysis items"
  - "Internet-based sample (MTurk-style), not population-representative"
  - "Response times (rt) present in source but unused at M3"
preprocessing_steps:
  - "irw_fetch -> wave-1 filter (irw_long2resp default)"
  - "1 of 1244 ids dropped by irw density threshold (0.1)"
  - "Verification fits used complete cases only (1225 of 1243 rows); raw zone retains all"
raw_hash: "4c07ac09bac7204a39b567e1c985a84687c450686250a68e2d15fc4346cd6be5"
silver_hash: null
gold_hash: "2bb5397992b6ed10eee9a65a2e02a7e7bfcee0b6aeaf6b89e477e0d40c80bfce"
created_at: 2026-08-01
created_by: claude-fable-5-m3
---

# much_tte_2025_matrixreasoning — Tier A (smoke)

Small, complete, cognitively canonical: figural matrix reasoning, 10 dichotomous
items, n=1,243, 0.35% missing. Selected as the smoke-test dataset — fast to fit,
clean license, published source with DOI.

**M3 verification runs (unregistered, suggestive only — no claims):** on the
1,225 complete cases, `fit_baseline(2pl)` converged (logLik −4701.52, 20
parameters) and `fit_copula_1f(bvn)` converged (logLik −4705.55, 10 parameters);
AIC 9443.0 vs 9431.1. The half-parameter near-tie is exactly the kind of
observation M4's registered, held-out benchmarks exist to test properly.
