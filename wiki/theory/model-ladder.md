# The model ladder — Levels 0–5

Charter §6. Implement simplest → most flexible; never jump to the most complex model.
Progression between levels is approved by the PI role, not assumed.

| Level | What | Key tools | Gate to pass |
|---|---|---|---|
| **0** | Conventional baselines: Rasch/1PL, 2PL, 3PL, GRM, GPCM, MIRT/bi-factor | `mirt`, `TAM` | Reproducible fits; stable model-result schema |
| **1** | IRTc product-copula wrapper — independence copula must recover the baselines | custom spec + code path | Estimates, log-likelihoods, predicted probabilities match baselines within numerical tolerance (differences explained + documented) |
| **2** | One-factor copula IRT: Gaussian/BVN, t, Frank, Clayton/Gumbel + rotations, Joe/BB if interpretable | `FactorCopula` | Reproduce ≥1 documented factor-copula example; simulation-based parameter recovery; comparison vs normal-ogive/MIRT |
| **3** | Local-dependence IRTc: testlet/item-bundle copulas, sparse residual vines, factor-tree residuals | — | Direct comparison with Q3-style residuals + limited-information fit; sensitivity to clustering assumptions; dependence-concentration visuals |
| **4** | Structured multidimensional IRTc: bi-factor, second-order, factor-tree, hierarchical | — | vs MIRT/bi-factor/two-tier baselines; do copula families add anything beyond more dimensions? |
| **5** | Extensions (only after 0–4 stable): response time + accuracy, longitudinal, CAT, DIF/group dependence, mixture copulas, knowledge-space hybrids | — | — |

## Special-case discipline (charter §4.3)

When claiming conventional IRT "is a special case," classify the relationship precisely:

1. **Exact equivalence** — algebraically identical likelihood after parameter mapping.
2. **Approximation** — similar ICCs/predictive behavior under scaling constants or asymptotics.
3. **Analogy** — conceptual only; not mathematically equivalent.

Nothing stronger than the evidence supports; the classification itself is a ledgered claim.
