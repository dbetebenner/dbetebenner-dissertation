# Activity log — newest first

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
