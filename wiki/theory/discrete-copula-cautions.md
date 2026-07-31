# Discrete-copula cautions

Charter §4.2 and §19 (first risk). Written at seed time deliberately — the charter's task
list (§21, task 3) requires this page to exist **before any model implementation claims**.

## The problem

Sklar's theorem guarantees a *unique* copula only under continuous marginals. Item responses
are typically dichotomous or ordinal, so the copula linking observed responses is **not
unique**, and any naive "copula-first is more mathematically sound" argument that leans on
continuous-Sklar uniqueness is invalid for our data. Identifiability for discrete outcomes
is a central theory work package (WP2), not a footnote.

## Candidate resolutions to investigate (in order of charter listing)

1. **Latent-continuous formulation** — observed categories as thresholds of latent continuous
   response variables; copulas defined on the latent scale.
2. **Exact rectangle-probability likelihood** — category probabilities as copula rectangle
   differences for binary/ordinal responses.
3. **Bayesian data augmentation** — latent continuous variables consistent with observed
   categories; sample/optimize the augmented posterior (Smith & Khaled 2012 is the anchor
   caution: estimation gets hard beyond the bivariate case).
4. **Parametric factor-copula construction** — build on existing factor-copula IRT models
   (Kadhem & Nikoloulopoulos 2021).
5. **Distributional/randomized transforms** — only if the literature review supports them for
   the target inference problem.

## Standing rule

No agent may claim IRTc is "more mathematically sound" without specifying: response scale,
margin definition, copula identification conditions, estimation procedure, and empirical
evidence. (Charter §4.2; mirrored in the spec's `additionalNotes`.)
