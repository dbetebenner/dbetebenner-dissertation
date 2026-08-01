# ENEM subsampling plan (M4) — frozen 2026-08-01

Governs every derivation from `enem_2019_1mil_lc` (IRW core v43.0, CC BY 4.0;
card: `cards/enem_2019_1mil_lc.md`). This plan is written and committed **before
the first byte is fetched**; amendments require a new dated section — the
original text is never edited (registry-style discipline).

## Source facts the plan relies on

1M examinees × 40 dichotomous language items (2019 ENEM LC section), density
1.0 per IRW metadata; long format with `id`, `item`, `resp`, `position`,
`booklet`. Passage membership is **not** carried by the IRW table — item
adjacency (`position`, within `booklet`) is the available local-dependence
proxy; empirical clustering (Q3-style residuals) will locate dependence
structure rather than assuming it.

## Subsamples

| id | n (persons) | Purpose | Seed |
|---|---|---|---|
| `enem19lc_bench10k` | 10,000 | The M4 benchmark subsample: baselines vs copula families, held-out prediction | 20260804 |
| `enem19lc_stress100k` | 100,000 | Scalability/timing only — never model-comparison evidence | 20260805 |

**Algorithm (both):** stratified simple random sampling by `booklet`,
proportional to booklet frequencies in the full table; within stratum, draw via
`sample.int` under the recorded seed after sorting person ids
lexicographically (deterministic ordering makes the draw reproducible from
IRW v43.0 + this plan alone). No exclusions: the table is complete-response by
construction; any deviation found at fetch time is recorded in the card, not
silently handled.

## Raw-zone policy for this table (plan-level decision)

The full 40M-row table is fetched **transiently** and not persisted: the
immutable source of record is IRW v43.0 itself (versioned, licensed, cited).
What lands in `data/raw/` (gitignored, hashed in the manifest) are the two
subsampled long snapshots — each re-derivable exactly from (IRW v43.0, this
plan's seeds and algorithm). This keeps the raw zone honest without storing a
~1 GB copy of a public versioned table.

## Splits (benchmark subsample only)

Person-level 80/20 train/test, `sample.int` under seed **20260806**, frozen in
`manifests/splits.yaml`. The stress subsample gets no split — it is not
evidence.

## What may consume these subsamples

- `enem19lc_bench10k`: M4 registered experiments only (entries in
  `experiments/registry.yaml` **before** any run; frozen metrics per the
  registry protocol). Also the Level-3 local-dependence work, under its own
  registrations.
- `enem19lc_stress100k`: runtime/memory profiling. Results may appear in
  reports only as compute benchmarks (charter WP5 family 7).

## Explicitly out of scope at M4

Booklet/position DIF, response-time modeling (no RT variable here), and any
between-year ENEM comparison. Each needs its own plan.
