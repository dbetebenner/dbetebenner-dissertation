# Milestones M0–M5

Charter §18, merged with the spec's FIRST ACTIONS (which govern M0 completion for this repo).

| # | Name | Done when | Status |
|---|---|---|---|
| **M0** | Scaffold | Spec read; wiki seeded from the charter; thesis restructured to the spec's nine chapters; toolchain verified once (app dev server runs, `R CMD check` passes, `build-thesis.yml` renders the PDF) | **complete 2026-07-31** — all four criteria green (irtc `9d309a0` + PDF rebuild `d2978f3`) |
| M1 | Baselines | Simulated binary + ordinal datasets; Rasch/2PL/GRM fits reproduce expected behavior; stable model-result schema; product-copula equivalence tests if implemented | **core complete 2026-07-31** (irtc `b92a5d0`): `simulate_2pl`/`simulate_grm`, `fit_baseline` via mirt, model-result schema v1 + JSON round-trip, 83 tests incl. smoke-level recovery. Product-copula wrapper (optional at M1) deferred to Level-1 work |
| M2 | Existing copula reproduction | `FactorCopula` smoke-tested; one documented example reproduced; parameter recovery for ≥1 family — reproducible and audited | pending |
| M3 | IRW ingestion | Authenticated/documented IRW access; ≥3 data cards; harmonized formats; fixed splits; both model classes run on ≥1 IRW dataset | pending |
| M4 | First benchmark report | Baselines vs one-factor copulas, held-out prediction + diagnostics, copula-family sensitivity, claim audit; **no unsupported superiority claims; failure modes documented** | pending |
| M5 | Auto-research loop | One controlled loop improves a predefined score without breaking audit gates — or clearly documents why it failed | pending |

Charter-M0 deliverables not in the spec's (a)–(d) list — API skeleton verification
(`/api/discover`), one smoke-test report render — fold into M1 preparation.

Note: the charter's later milestones execute **inside this repo family** (app repo + `irtc`
submodule), not in dissertation-ai.
