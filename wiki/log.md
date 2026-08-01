# Activity log — newest first

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
