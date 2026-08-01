# Data zones (charter WP4)

The IRW pipeline's zoned layout. **Not to be confused with the repo-root `raw/`**,
which holds the author's uploaded source documents (read-only for AI agents) — these
zones hold *item-response data* flowing toward benchmarks.

| Zone | Contents | Committed? |
|---|---|---|
| `raw/` | Immutable IRW downloads / source snapshots. Never mutated. | No (gitignored; existence + hash recorded in manifests) |
| `bronze/` | Parsed, minimally transformed | No (gitignored; rederivable from raw + logged transformations) |
| `silver/` | Harmonized long/wide person-item-response schemas | Only if small; else manifest-hashed |
| `gold/` | Benchmark-ready matrices + fixed train/validation/test splits | Only if small; else manifest-hashed |
| `manifests/` | `datasets.yaml`, `splits.yaml` — hashes, licenses, provenance, transformations | **Always** |
| `cards/` | One data card per dataset (schema in `cards/README.md`) | **Always** |

## Rules (charter WP4 gates)

- Every dataset has provenance and license fields **before use**.
- Every transformation is logged with input hash and output hash.
- Response recodes are documented and reversible where possible; missingness
  handling is explicitly recorded.
- Raw downloads are never mutated — corrections happen bronze-onward.
- Splits are fixed once in `manifests/splits.yaml` and are **frozen surfaces**
  during any registered experiment (see `wiki/experiments/registry-protocol.md`).

## Access

IRW data arrives via the `irw` R package over authenticated Redivis — the route,
auth setup, and dataset-selection criteria are documented in
`wiki/data/irw-access.md`.
