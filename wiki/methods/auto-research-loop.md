# Auto-research loop

Charter §11. Not "let agents research" — a controlled system with fixed evaluation rules.

## Editable surfaces (agents may propose changes)

Model family selection · copula candidate lists · optimizer settings · priors/regularization
· simulation designs · preprocessing variants (declared before fitting) · diagnostic plots ·
report templates · claim extraction/audit prompts · dashboard components.

## Frozen surfaces (never changed inside an autonomous run)

Raw data · split definitions · primary metrics · acceptance thresholds · baseline model
definitions · claim-verification rules · source whitelist/blacklist · the human-approved
charter.

## Phases

1. **Setup** (human + planning agent): choose question and scope; select datasets/scenarios;
   freeze metrics, thresholds, baselines; declare editable surfaces; run the baseline;
   generate the claim-audit checklist; approve the experiment manifest.
2. **Autonomous** (agent swarm): mutate ONE controlled element → run → score against frozen
   metrics → keep only if it improves without violating gates → log the attempt (failures
   included) → repeat until stopping criteria (max experiments, compute budget, N
   non-improvements, convergence-failure rate, claim-audit failure, or model-class change
   requiring human review).
3. **Debrief** (human + synthesis agent): before/after metrics; inspect accepted AND
   rejected changes; sensitivity analyses; claim audit; release report; update wiki + log.

## Scoring

The charter's §11.6 weighted score (held-out log-loss gain 0.30, calibration 0.20, residual
dependence 0.15, parameter stability 0.10, interpretability 0.10, compute 0.10, audit pass
0.05, minus penalties for nonconvergence, unverified claims, unjustified complexity) is used
only **after** individual metrics are inspected. A composite must never hide a regression.
