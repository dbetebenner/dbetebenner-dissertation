# Activity log — newest first

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
