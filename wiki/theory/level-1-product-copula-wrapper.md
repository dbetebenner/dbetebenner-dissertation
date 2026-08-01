# Level 1 — the product-copula wrapper (formal spec)

The charter's Level-1 deliverable: "a formal model spec and code path where the copula
is fixed to independence and results match baseline models within numerical tolerance."
Code: `R/fit-irtc.R` in the irtc package. Acceptance test:
`tests/testthat/test-irtc-level1.R` (claim C0004, re-verified every CI run).

## Model

For person $i$ with binary response vector $Y_i = (Y_{i1}, \ldots, Y_{iJ})$ and ability
$\theta_i \sim N(0, 1)$, IRTc writes the conditional joint via a copula over the
item-response marginals. With 2PL marginals

$$F_j(1 \mid \theta) = P(Y_{ij} = 1 \mid \theta) = \operatorname{logit}^{-1}\!\big(a_j(\theta - b_j)\big), \quad a_j > 0,$$

and the **independence copula** $C(u_1, \ldots, u_J) = \prod_j u_j$, the copula
rectangle probability collapses to the familiar factorization

$$P(Y_i = y_i \mid \theta_i) = \prod_j F_j(1 \mid \theta_i)^{y_{ij}} \big(1 - F_j(1 \mid \theta_i)\big)^{1 - y_{ij}}$$

— i.e., conventional local-independence IRT **is** the independence-copula case of
IRTc, by construction (charter §4.3, relationship class: *exact equivalence*).

## Estimation

Marginal maximum likelihood with the ability integrated over the standard normal
prior by Gauss quadrature ($Q = 61$ points via `statmod::gauss.quad.prob`):

$$\ell(a, b) = \sum_i \log \sum_q w_q \, P(Y_i = y_i \mid \theta = t_q),$$

optimized by `nlminb` with $\log a_j$ free (positivity by parameterization),
log-sum-exp stabilized. This is the same objective the mirt 2PL maximizes (EM with
normal prior, fixed latent variance), so agreement is expected — and required.

## Acceptance evidence (seeded design: n = 1000, J = 10, seed 42)

| Quantity | Observed agreement vs mirt | Test bound |
|---|---|---|
| Log-likelihood | < 1e-5 | 1e-5 (relative) |
| Item parameters (max abs diff, a and b) | ≤ 1e-4 | 0.01 |
| Predicted $P(Y{=}1 \mid \theta)$ on $\theta \in [-3, 3]$ | ≤ 1.2e-5 | 0.001 |

## Scope and boundaries

- Binary responses, 2PL marginals only. The Rasch equivalence is **not** claimed at
  this rung: mirt's `Rasch` itemtype frees the latent variance (different
  parameterization), so a naive comparison would conflate parameterizations —
  deferred, with the discrete-data cautions of
  [discrete-copula-cautions.md](discrete-copula-cautions.md) untouched by this result
  (independence needs no copula-uniqueness argument).
- Non-independence copulas are refused by `fit_irtc()` at this rung; structured
  dependence arrives with the Level-2+ likelihoods (one-factor copulas via
  FactorCopula are already wrapped separately as `fit_copula_1f()`, M2).
