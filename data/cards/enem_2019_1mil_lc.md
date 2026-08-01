---
dataset_id: enem_2019_1mil_lc
source_name: "ENEM 2019 language section, 1M-person subsample (INEP/Brazil) — IRW core v43.0"
source_url: "https://stanford.redivis.com/datasets/as2e-cv7jb41fd/tables/925y-76sfe03m2?v=43.0"
irw_version: "v43.0"
license: "CC BY 4.0"
provenance_summary: >-
  Language portion (linguagens e códigos) of Brazil's 2019 national ENEM exam,
  one-million-person subsample. Official microdata at
  https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/enem;
  harmonized by IRW. Metadata captured 2026-08-01; FETCH DEFERRED (40M rows) —
  raw/gold hashes pending the M4 subsampling plan.
construct: "Language proficiency (ENEM LC 2019)"
response_type: dichotomous
n_persons: 1000000
n_items: 40
n_responses: 40000000
missingness_rate: 0.0
scoring_rules: "resp is IRW-scored 0/1; source variables include position and booklet"
item_group_variables: ["booklet", "position"]
known_limitations:
  - "Not yet fetched: card is metadata-only until the M4 subsampling plan fixes n and strata"
  - "Portuguese-language items; construct interpretation requires the ENEM framework"
  - "Operational high-stakes exam: item exposure and booklet design effects are real"
preprocessing_steps:
  - "None yet — fetch deferred"
raw_hash: null
silver_hash: null
gold_hash: null
created_at: 2026-08-01
created_by: claude-fable-5-m3
---

# enem_2019_1mil_lc — Tier C (stress) + suspected local dependence

The stress-test selection: one million examinees, 40 dichotomous language items,
complete responses, representative sample. Doubly valuable: reading-passage-based
items plus recorded `booklet`/`position` variables make this the project's
natural **suspected-local-dependence** dataset (charter 13.1) — testlet copulas
(Level 3) will want exactly this structure. Deliberately metadata-only at M3:
pulling 40M rows precedes a subsampling design, which belongs to M4's registered
benchmark plan, not an ingestion scaffold.
