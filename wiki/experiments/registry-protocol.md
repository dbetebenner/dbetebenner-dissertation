# Experiment registry protocol

Charter §16. **Every experiment is registered before it runs** — no post-hoc entries. The
registry lives at `../../experiments/registry.yaml`.

Each entry pre-declares:

```yaml
run_id: exp_YYYY_MM_DD_NNN
research_question: "…"
dataset_id: …
split_id: …
models: [baseline_…, irtc_…]
metrics:
  primary: heldout_logloss
  secondary: [brier_score, q3_residual_summary, runtime_seconds]
acceptance:
  min_logloss_gain: 0.005
  max_convergence_failure_rate: 0.05
  require_claim_audit: true
frozen_files: [data/manifests/splits.yaml, experiments/eval_scripts/…]
editable_files: [engines/R/R/…, experiments/configs/…]
seed: NNNNNNNN
status: planned | running | complete | failed | rejected
```

Run artifacts land under `experiments/runs/<run_id>/` (`config.yaml`, `metrics.json`,
`logs.txt`, `artifacts/`). Frozen files listed in an entry may not change while the run is
`planned` or `running`; edits to them invalidate the run.
