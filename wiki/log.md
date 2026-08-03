# Activity log — newest first

## 2026-08-03 — M4 complete: the native likelihood removed the wall; the tier-A signal did not generalize

- **Benchmark report published** ([experiments/benchmark-m4.qmd](../experiments/benchmark-m4.qmd)):
  rendered entirely from committed run artifacts, with exploratory Q3
  diagnostics (mean Q3 −0.106 ≈ the −1/(J−1) reference, but 11/45 pairs
  beyond |0.2|, extreme −0.349 — real local-dependence structure the 2PL
  leaves behind; a Level-3 input).
- **Native Level-2 likelihood** (irtc `ff02ee3`): `fit_copula_1f(engine =
  "irtc")` — person-wise marginal likelihood from the 1e-6-verified
  h-functions, no O(2^J) joint table, nlminb with an item-local gradient
  (a full gradient costs ~2 objective evaluations regardless of J).
  Reproduction oracle in CI: identical cutpoints (1e-8), loglik to 1e-5,
  thetas/taus to 1e-2 vs `mle1factor`, all six families. A J=45 fit — where
  the wrapped engine cannot allocate — converges in seconds.
- **exp_2026_08_03_004/_005** (registered `aea2a6d` before running, v2
  frozen evaluator = v1 + the native model mapping): all 12 copula fits at
  J=50/40 completed. The gates held a third and fourth time — tma: the 2PL
  baseline predicted best outright (BVN's better train AIC again failed
  held-out); ENEM: gum's 0.0002 edge was two orders under the gate AND rjoe
  failed convergence (zero-failure criterion violated; documented, not
  hidden). rjoe's 10-item advantage did not generalize — family ranking is
  dataset-dependent (C0008). Native-engine capability ledgered as C0007.
- **M4 is complete**: five registered runs, no superiority claims anywhere,
  three distinct failure modes documented. Next: M5 (the auto-research
  loop) and/or the Level-3 local-dependence structures the Q3 pattern
  motivates.

## 2026-08-02 — M4: the first registered benchmark ran — the gates held, twice

- **Registration before execution** (`97d803f`): three experiments — 2PL baseline vs
  six one-factor copula families on the frozen splits — with the frozen evaluator
  (`experiments/eval/heldout-benchmark.R`: hash-gated data integrity, no verdicts
  emitted) and acceptance fixed in advance (gain ≥ 0.005/response, zero
  convergence failures, claim audit required).
- **exp_001 (matrixreasoning)**: all 7 models converged. **Rotated-Joe won held-out**
  (0.369797 vs baseline 0.373756, half the parameters) — but the 0.00396 gain sits
  under the pre-registered threshold, so **no superiority claim** (C0005). The M3
  suggestive BVN observation **failed held-out** (0.374969, worse than baseline) —
  the project's first documented failure case, exactly as the charter intends.
  rjoe's lower-tail dependence (joint incorrect answers among low-ability
  examinees) is now a Level-3 hypothesis, not a claim.
- **exp_002/_003 (tma 50 items, ENEM 40 items)**: baselines fine; **every
  FactorCopula fit hit an engine wall** — its first stage builds an O(2^J) joint
  contingency table, overflowing at J≥40 (C0006). The documented failure motivates
  the native Level-2 likelihood: the h-functions already live in
  `heldout_logloss` (verified to 1e-6 against the engine), so optimization needs
  no joint table.
- One evaluator bug found by the run itself (2PL boundary probabilities → NaN):
  regression-tested, fixed (irtc `323eb20`), registry amended append-only, clean
  re-run. Next: the M4 benchmark report + Q3 diagnostics, then the native
  Level-2 likelihood.

## 2026-08-01 — M4: held-out prediction machinery landed

- `heldout_logloss()` (irtc `6c0eb00`): marginal log-likelihood of unseen persons
  at fixed training parameters, per-response log-loss reported — the M4 primary
  metric, for **both** model classes. Copula path implements the conditional
  h-functions (bvn, frk, gum, rgum, joe, rjoe; rotations as 180° survivals) over
  the stored first-stage cutpoints; `fit_copula_1f` now carries its cutpoints.
- Correctness by self-consistency, enforced in tests forever: on training data at
  fitted parameters the evaluator reproduces fit_irtc to 1e-8, mirt to 1e-4, and
  mle1factor to 1e-6 for every supported family — the family sweep is an exact
  verification of our h-function math against FactorCopula's own likelihood.
  All green on the first run. Missing responses skipped, never imputed.
- Next (M4): registered experiments — `experiments/registry.yaml` entries with
  frozen eval scripts naming this machinery, then the benchmark runs, sensitivity,
  and the claim audit.

## 2026-08-01 — M4 opened: ENEM subsampling plan frozen, then executed

- Plan committed **before any fetch** (`3a673bb` — the git history proves the
  design-before-data ordering): stratified-by-booklet SRS, bench n=10,000
  (seed 20260804, registered-experiment evidence only) + stress n=100,000
  (seed 20260805, timing only, never evidence), id-sorted deterministic draws,
  transient full-table fetch with IRW v43.0 as the source of record, split seed
  20260806, amendments append-only.
- Executed (`60a9d64`): 40M rows fetched transiently, both draws complete with
  0 missing (matching metadata), hashes verified from disk, bench gold + split
  committed, stress gold + raw longs gitignored and manifest-hashed.
- M4 remaining: held-out prediction machinery in the irtc package (marginal
  log-loss for unseen persons, both model classes), registered experiments in
  `experiments/registry.yaml` with frozen eval scripts BEFORE any comparison
  run, copula-family sensitivity, claim audit of the tier-A AIC observation.

## 2026-08-01 — M3 complete: IRW ingestion live; both model classes ran on real data

- Redivis auth verified (scoped read token per the new secret-hygiene discipline);
  2,530 IRW tables visible. Tiered, license-clean (all CC BY 4.0) selection:
  **A** `much_tte_2025_matrixreasoning` (1,243×10 after wave-1 filter, fetched),
  **B** `tma` (5,399×50, fetched), **C** `enem_2019_1mil_lc` (1M×40,
  metadata-only card — fetch deferred to the M4 subsampling plan; its
  `booklet`/`position` variables make it the natural local-dependence dataset).
- WP4 discipline held: three data cards, manifest rows with verified sha256 hashes
  (one transcription error caught by recomputation — hashes are copied from tool
  output, never retyped), fixed person-level 80/20 splits under recorded seeds,
  source bibtex captured via `irw_save_bibtex` (Much et al. 2025; Taylor 1953;
  ENEM). Preprocessing recorded: irw wave-1 + density-threshold filters.
- `fit_copula_1f` now supports **binary** items (single cutpoint; BVN recovers
  normal-ogive behavior) — guard relaxed with tests after probing mle1factor on
  real binary data.
- **M3 done-when met**: on tier-A complete cases (1,225×10), `fit_baseline(2pl)`
  logLik −4701.52 (20 par) and `fit_copula_1f(bvn)` logLik −4705.55 (10 par);
  AIC 9443.0 vs 9431.1. The half-parameter near-tie is recorded as a
  **suggestive, unregistered observation only** — M4's registered, held-out
  benchmarks exist to test it. No superiority claim is made or permitted here.

## 2026-08-01 — M3 opened: IRW access route documented, data zones scaffolded

- Access route verified and documented ([data/irw-access.md](data/irw-access.md)):
  `irw` v1.0.0 installed from GitHub; key API surfaced (`irw_list_tables`,
  `irw_filter`, `irw_fetch`, `irw_save_bibtex`); **Redivis authentication confirmed
  required** — unauthenticated calls hang on an interactive flow. Maintainer setup
  steps written (Redivis account + `REDIVIS_API_TOKEN` in `~/.Renviron`).
- Data zones scaffolded per WP4: `data/{raw,bronze,silver,gold,manifests,cards}/`,
  empty `datasets.yaml` + `splits.yaml` manifests, card schema in `data/cards/README.md`;
  raw/bronze gitignored (manifest-hashed, never committed). Zone `data/raw/` is
  distinct from the repo-root `raw/` uploads directory — noted in `data/README.md`.
- **Blocked on:** maintainer Redivis token. Then: tiered selection (A/B/C), three
  data cards, harmonized formats, fixed splits — and both model classes run on ≥1
  IRW dataset (M3 done-when).

## 2026-08-01 — Level 1: the product-copula wrapper (the ladder's first IRTc rung)

- `fit_irtc()` — IRTc's own code path (marginal ML, normal prior, 61-point
  quadrature, log-parameterized discriminations), copula fixed to independence.
  Acceptance test vs the mirt 2PL on seeded data: log-likelihood within 1e-5, item
  parameters within 1e-4, predicted probabilities within 1.2e-5 — ledgered as C0004.
- Formal spec: [theory/level-1-product-copula-wrapper.md](theory/level-1-product-copula-wrapper.md)
  — conventional local-independence IRT is the independence-copula case *by
  construction* (exact equivalence). Rasch equivalence deliberately not claimed
  (parameterization mismatch documented). Non-independence copulas refused until the
  Level-2+ likelihoods.
- 124 tests green; the deferred M1-optional equivalence deliverable is now closed.
- Next: M3 (IRW ingestion — blocked on maintainer Redivis auth) or Level-2 IRTc
  likelihoods beyond the FactorCopula wrapper.

## 2026-07-31 — M2: existing copula reproduction

- The documented FactorCopula PE one-factor example reproduces in-test (loglik
  −151.9777, Joe/Gumbel dependence parameters within 1e-2 of captured reference
  values) — ledgered as C0003 (implementation capability, re-verified on every CI run).
- `fit_copula_1f()` (irtc `494a4a5`): ordinal one-factor copula fits for
  single-parameter families, returning the standardized model result; honest
  convergence proxy documented (mle1factor exposes no diagnostic).
- Seeded Gumbel recovery: max abs error 0.27 at n=500 (0.6 smoke bound in tests).
- Next: Level-1 product-copula wrapper with its numerical-tolerance equivalence test
  (the deferred M1 optional), then M3 (IRW ingestion — needs Redivis auth).

## 2026-07-31 — M1 core: simulators, baselines, model-result schema

- Test-first in the irtc package (irtc `b92a5d0`): `simulate_2pl()` and `simulate_grm()`
  (seeded, provenance-carrying, ordered GRM thresholds), `fit_baseline()` wrapping mirt
  for Rasch/2PL/GRM, and the WP3 model-result schema v1 (`new_model_result()` with
  validation, lossless JSON round-trip, convergence surfaced loudly in print).
- 83 tests: structure, seed reproducibility, input validation, binary/ordinal mismatch
  guards, smoke-level parameter recovery (difficulty r > 0.9; pooled GRM thresholds
  r > 0.9). `R CMD check`: 2 pre-existing template NOTEs, no warnings/errors.
- mirt added to Suggests. The optional product-copula equivalence wrapper is deferred to
  Level-1 work (it is the Level-1 deliverable itself, with its numerical-tolerance
  acceptance test).
- Next: M2 — FactorCopula smoke tests + reproduction of a documented factor-copula
  example; M1 recovery *study* (beyond smoke level) folds into the WP5 benchmark design.

## 2026-07-31 — M0 complete

- Thesis restructured to the spec's nine chapters (irtc `9d309a0`); front/back matter,
  `thesis.cls`, `dataimago.sty` untouched. `Build thesis PDF` and `R-CMD-check` both green;
  rebuilt `docs/thesis.pdf` (80K) committed by CI (`d2978f3`); submodule pointer bumped here.
- Toolchain verified: `npm install && npm run dev` serves the landing page (200); local
  `R CMD check` — 2 template-metadata NOTEs, no warnings/errors.
- `/api/discover` intentionally absent until the `dataimago::ai()` generation pass — folded
  into M1 preparation per [methods/milestones.md](methods/milestones.md).
- Next (M1): simulated binary 2PL + ordinal GRM datasets, `mirt`/`TAM` baseline fits,
  model-result schema; charter §21 first-batch tasks.

## 2026-07-31 — M0: knowledge base seeded

- Repo provisioned via dissertation.ai (Test-1 run): spec committed, five source documents
  landed in `raw/` by category, `irtc` submodule linked at `packages/r-packages/irtc`.
- Wiki seeded from the charter (`raw/background/IRTc.md`): overview, model ladder,
  discrete-copula cautions, WP1–WP6, claim-ledger protocol, auto-research loop, milestones,
  registry protocol.
- Skeletons created: `research/literature/bibliography.bib` (§3.2 source anchors),
  `research/literature/claims.yaml` (C0001 = founding conjecture, `hypothesis`),
  `experiments/registry.yaml` (empty).
- Next: restructure thesis chapters to the spec's nine (M0c), then toolchain verification
  (M0d): app dev server, `R CMD check`, `build-thesis.yml` PDF.
