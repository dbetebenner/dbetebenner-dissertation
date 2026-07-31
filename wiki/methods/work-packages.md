# Work packages WP1–WP6

Charter §7. Each WP lists its goal, headline outputs, and the quality gates that bind agents.

## WP1 — Literature and claim foundation
Goal: a non-hallucinated, citation-backed research base.
Outputs: `research/literature/{bibliography.bib, claims.yaml, lit_matrix.parquet}`,
`wiki/theory/irtc_literature_review.md`, `wiki/theory/discrete_copula_cautions.md`.
Gates: no report paragraph carries an empirical/historical claim without a source ID; no
AI-generated citation accepted until verified (DOI, publisher, arXiv, CRAN, official docs);
a separate auditor agent inspects every final report claim.

## WP2 — Mathematical specification
Goal: the formal IRTc theory document — notation, conditional/marginal likelihoods for
binary and ordinal items, copula placement options, rectangle probabilities, special-case
mappings, identifiability, parameter interpretation (incl. tail dependence and asymmetry).
Outputs: `wiki/theory/{irtc_formal_spec, special_cases, identifiability, parameter_interpretation}.md`.
Gates: every theorem-like statement gets proof, citation, or a `conjecture` label; every
discrete likelihood states the exact probability calculation; every model has a simulation
recipe before touching IRW data.

## WP3 — Software implementation
Goal: a testable, modular model engine — wrap `mirt`/`TAM`/`FactorCopula` first, custom
likelihoods only after package baselines reproduce.
Outputs: `packages/irtc-core/`, `engines/R/` (renv), optional `engines/python/`,
`tests/{model_equivalence, parameter_recovery, predictive_checks}/`.
Gates: unit + smoke tests per model; every fit returns convergence status; no failed fit is
silently included in comparisons; baselines run before copula extensions are scored.

## WP4 — IRW data pipeline
Goal: acquire, harmonize, document, version real item-response data (raw → bronze → silver
→ gold zones + manifests; data card per dataset; immutable raw downloads; reproducible splits).
Outputs: `data/manifests/{datasets,splits}.yaml`, `data/cards/<id>.md`, producer endpoints.
Gates: provenance + license before use; every transformation logged with input/output
hashes; recodes documented and reversible where possible; missingness handling recorded.

## WP5 — Benchmarking and sensitivity
Goal: fair, reproducible comparison of IRTc vs conventional frameworks across simulation,
recovery, predictive, fit, interpretability, robustness, and compute benchmarks.
Primary metrics: held-out log loss and Brier; then marginal likelihood, AIC/BIC/SABIC, M2,
Q3-style residuals, calibration by ability strata, recovery RMSE, parameter stability,
runtime/convergence.
Gates: evaluation scripts immutable during an auto-research run; comparisons use held-out
data; the best model must beat a complexity-adjusted baseline, not merely add parameters;
sensitivity analyses precede any superiority claim.

## WP6 — Reporting and synthesis
Goal: expert-grade outputs — research memos, methods notes, data reports, experiment
reports, executive dashboard, reproducibility appendix.
Outputs: `reports/{theory,benchmarks,data,audit,release}/…` including `irtc_whitepaper_v0.md`.
Gates: claims stratified (`established` / `supported by this benchmark` / `suggestive` /
`speculative`); every plot links to its data + code; every table carries model version,
dataset version, split ID, seed; failure cases reported as first-class results.
