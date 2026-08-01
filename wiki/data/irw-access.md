# IRW access route (M3)

The Item Response Warehouse is the project's source of real benchmark data
(S0001/S0003 in the bibliography): 900+ harmonized open item-response datasets.
Access is programmatic via the **`irw` R package** over an authenticated
**Redivis** connection.

## The route

- Package: `irw` (not on CRAN) — `remotes::install_github("itemresponsewarehouse/Rpkg")`
  (verified installed 2026-08-01, v1.0.0; pulls `redivis` + arrow/httr2).
- Key surface (from the installed namespace): `irw_list_tables()`,
  `irw_metadata()`, `irw_info()`, `irw_filter()` (by tags/properties),
  `irw_fetch()` / `irw_download()` (data), `irw_license_options()` /
  `irw_tag_options()`, `irw_save_bibtex()` (citation capture for WP1).
- **Authentication is required before any data call.** The `redivis` client
  authenticates via a Redivis API token; without one, calls block on an
  interactive browser flow (observed: `irw_list_tables()` hangs in
  non-interactive R until authenticated).

## Maintainer setup (one-time, ~5 minutes)

1. Create a free account at https://redivis.com (GitHub SSO works).
2. Workspace → Settings → API tokens → generate a token (data-access scope).
3. Put it in `~/.Renviron` as `REDIVIS_API_TOKEN=<token>` (never in the repo;
   this is a credential and stays out of git by the same containment rule as
   every other secret).
4. Verify: `Rscript -e 'library(irw); nrow(irw_list_tables())'` returns a count
   instead of hanging.

## Selection plan (charter 13.1–13.2)

Once authenticated, select three initial datasets via `irw_filter()` +
`irw_metadata()`:

- **Tier A (smoke)**: small dichotomous, complete responses, clear license —
  integration tests and report-template checks.
- **Tier B (primary)**: moderate n, documented scoring, plausibly
  unidimensional AND one with suspected local dependence (testlets/passages) —
  the first fair IRTc-vs-baseline comparison.
- **Tier C (stress)**: large or high-missingness — scalability and robustness.

Each selection gets a data card (`data/cards/`), a manifest row with license +
hashes, and a bibtex entry via `irw_save_bibtex()` before any model run.
License discipline: only datasets whose IRW license terms permit our benchmark
use; record the license string verbatim in the card.
