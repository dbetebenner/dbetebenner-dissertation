# IRTc — overview

**Working title:** IRTc: Copula-Based Item Response Theory
**Charter:** [`raw/background/IRTc.md`](../raw/background/IRTc.md) (2026-05-13) — a research-orchestration
brief, not a claim of completed theory or proven novelty.

## Mission

Build an AI-native research application investigating whether a copula-first formulation of
Item Response Theory (IRTc) provides a mathematically cleaner and empirically more flexible
framework for educational measurement. Four tracks run in parallel (charter §1):

1. **Research** — a grounded, citation-backed literature base (IRT, local independence and
   dependence, copula theory, Sklar's theorem, factor/vine copulas, discrete-copula limits).
2. **Formalize** — an IRTc model family separating item-response marginals from dependence
   structures, with conventional IRT located as special/limiting cases and identifiability
   assumptions stated explicitly.
3. **Implement and benchmark** — conventional baselines vs copula alternatives on simulated
   and Item Response Warehouse (IRW) data: fit, prediction, diagnostics, interpretability,
   sensitivity, compute cost.
4. **Report and iterate** — auto-research loops under fixed evaluation rules; reproducible
   reports fit for expert review.

## The founding conjecture — hypothesis, never evidence

> If Lord-era IRT had access to Sklar's theorem, copula theory, and modern compute, some of
> IRT might have developed as a dependence-modeling framework in which local independence is
> the independence-copula case rather than the default assumption.

Ledgered as claim **C0001** (`hypothesis`, source: user context). It generates research
questions; it supports no claim. No agent may assert IRTc superiority without specified
response scale, margin definition, identifiability conditions, estimation procedure, and
audited empirical support (charter §4.2, §23; spec `additionalNotes`).

## Dual purpose

The project is simultaneously the first end-to-end stress test of the dataimago research
machine: claim ledger, registered experiments with frozen metrics, loops restricted to
declared editable surfaces, reproducible Quarto reporting. Findings about the framework feed
back into dataimago; findings about IRTc feed the dissertation.

## Where things live

- Thesis manuscript: `packages/r-packages/irtc/ui/www/` (nine chapters per the spec)
- Uploaded sources: `raw/` (read-only) — see the spec's `context` block for descriptions
- Claim ledger: `research/literature/claims.yaml` · Registry: `experiments/registry.yaml`
