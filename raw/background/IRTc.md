# IRTc Auto-Research Blueprint for dataimago

**Working title:** IRTc: Copula-Based Item Response Theory Research, Data, Benchmarking, and Reporting System  
**Audience:** AI agents operating inside the dataimago AI-native web-application framework  
**Date:** 2026-05-13  
**Status:** Research-orchestration brief, not a claim of completed theory or proven novelty  
**Primary outcome:** A reproducible research web application that can ingest item response data, implement and compare copula-based and conventional IRT models, generate auditable reports, and maintain a citation-backed research knowledge base.

---

## 1. Mission

Build an AI-native research application for investigating whether a copula-first formulation of Item Response Theory (IRTc) can provide a mathematically cleaner and empirically more flexible framework for educational measurement and psychometrics.

The project must do four things in parallel:

1. **Research:** Build a grounded, citation-backed literature base on IRT, normal-ogive/logistic models, Rasch models, multidimensional IRT, local independence, local dependence, copula theory, Sklar's theorem, factor copula models, vine copulas, discrete copula limitations, and existing copula item-response models.
2. **Formalize:** Define a family of IRTc models that separates item response marginals from dependence structures, explicitly identifies where conventional local-independence IRT appears as a special or limiting case, and states all identifiability assumptions.
3. **Implement and benchmark:** Fit conventional IRT baselines and copula-based alternatives to simulated and real item-response datasets, including datasets from the Item Response Warehouse (IRW), then compare model fit, predictive performance, diagnostics, interpretability, sensitivity, and computational cost.
4. **Report and iterate:** Use auto-research loops to propose, test, keep, or reject model, data, and reporting improvements under fixed evaluation rules; generate reproducible reports and dashboards suitable for expert review.

The project should treat the founding conjecture as a hypothesis:

> If Lord-era IRT had access to Sklar's theorem, copula theory, and modern compute, some of IRT might have developed as a dependence-modeling framework in which local independence is the independence-copula case rather than the default assumption.

This conjecture is useful as a generator of research questions. It is not evidence by itself.

---

## 2. Framework context from dataimago

The attached `dataimago-ai` README describes a Turborepo + pnpm-workspaces monorepo containing two Next.js applications and shared libraries:

- `apps/hub/`: hosted platform that onboards users and generates AI-native application repositories.
- `apps/template/`: generated-application template that `dataimago::ai()` clones into each user's project repository.
- `packages/shared-utils/`: TypeScript types, `ProducerDriver` runtime, and `DataimagoApiClient`.
- `packages/mcp-tools/`: MCP schema loader and Zod-validated tool-routing proxy.

The README also situates `dataimago-ai` in a three-repo stack:

- `dataimago-design`: design system and AI-maintained knowledge wiki.
- `dataimago-rpkg`: R orchestration layer for R-heavy projects.
- `dataimago-ai`: Next.js platform and generated project scaffold.

For IRTc, use this architecture as follows:

- Use **dataimago hub** to generate a dedicated IRTc research application repository.
- Use **the template app** as the reproducible web surface for data discovery, dataset ingestion, model runs, report production, and scheduled experiment loops.
- Use **producer drivers** to expose IRW datasets, transformed benchmark datasets, model outputs, fit diagnostics, and report artifacts through stable API endpoints.
- Use **mcp-tools** to expose safe, schema-validated AI actions such as `search_literature`, `ingest_irw_dataset`, `fit_baseline_irt`, `fit_copula_irt`, `compare_models`, `generate_report`, and `audit_claims`.
- Use **dataimago-rpkg** or an R subproject for model implementations that rely on R packages such as `mirt`, `TAM`, and `FactorCopula`.
- Use **dataimago-design** for a consistent research-report UI, knowledge wiki templates, and report component conventions.

---

## 3. Source anchors that agents must know

Use these as initial source anchors. Agents must expand them through citation-backed literature review before making strong claims.

### 3.1 Project-provided context

- `README.md` supplied by the user: dataimago architecture, app/template/package roles, current status, generated-repo workflow.
- `Pasted text (2).txt` supplied by the user: speculative discussion framing IRTc as a copula-first counterfactual extension of early IRT.

### 3.2 Web and literature anchors verified on 2026-05-13

- The Item Response Warehouse (IRW) describes itself as a collection of open, harmonized item response datasets, with cross-classified responses by measurement focus and item, and data types including dichotomous, polytomous, continuous, and response-time-enriched data.  
  Source: https://itemresponsewarehouse.org/
- The `irw` R package provides programmatic access to IRW, with Redivis authentication required for access.  
  Source: https://itemresponsewarehouse.github.io/Rpkg/
- A 2025 Behavior Research Methods article introduces IRW as a large standardized repository with more than 900 datasets in version 28.2 and over 2 billion item responses, available through website and API access.  
  Source: https://link.springer.com/article/10.3758/s13428-025-02796-y
- The CRAN `FactorCopula` package supports factor, bi-factor, second-order, and factor-tree copula models, including models for item response data.  
  Source: https://cran.r-project.org/web/packages/FactorCopula/index.html
- `FactorCopula` package documentation lists diagnostics for tail dependence and asymmetry, estimation, model selection, and M2 goodness-of-fit functions for factor and structured copula models.  
  Source: https://rdrr.io/cran/FactorCopula/man/FactorCopula-package.html
- Kadhem and Nikoloulopoulos describe bi-factor and second-order copula models for item response data, including asymmetric and tail dependence behavior that can exceed what discretized multivariate normal models capture.  
  Source: https://www.cambridge.org/core/journals/psychometrika/article/bifactor-and-secondorder-copula-models-for-item-response-data/DD83BEC026B9180719F031E934A9E311
- The `mirt` R package supports unidimensional and multidimensional IRT, exploratory and confirmatory models, EM and MHRM estimation, bi-factor/two-tier models, multiple-group analyses, mixed-effects designs, and DIF-related workflows.  
  Source: https://philchalmers.github.io/mirt/
- The `TAM` R package supports marginal and joint maximum likelihood estimation for unidimensional and multidimensional IRT models including Rasch, 2PL, 3PL, GPCM, multi-faceted Rasch, nominal response, structured latent class, mixture IRT, and located latent class models.  
  Source: https://cran.r-project.org/web/packages/TAM/index.html
- Smith and Khaled's JASA article on copula models with discrete margins emphasizes that estimation can become difficult beyond the bivariate case and proposes Bayesian data augmentation with continuous latent variables.  
  Source: https://ideas.repec.org/a/taf/jnlasa/v107y2012i497p290-303.html
- The auto-research loop described in the AI Maker article emphasizes an editable surface, a measurable score, and a time-boxed test loop, then extends this into setup, autonomous loop, and debrief phases.  
  Source: https://aimaker.substack.com/p/how-i-built-skill-improves-all-skills-karpathy-autoresearch-loop

---

## 4. Definition of IRTc

### 4.1 Working definition

**IRTc** is a proposed family of item-response models that uses copulas to represent dependence structures among latent traits, item-response variables, residual item dependencies, testlets, item bundles, response times, or multidimensional ability components.

In conventional IRT, for a response vector `Y_i = (Y_i1, ..., Y_iJ)` from person `i`, a basic local-independence model writes:

```text
P(Y_i = y_i | theta_i) = product_j P(Y_ij = y_ij | theta_i, item_j_parameters)
```

IRTc asks what becomes possible if that product structure is replaced or generalized by a copula-mediated conditional joint distribution:

```text
P(Y_i <= y_i | theta_i) = C_theta(
  F_1(y_i1 | theta_i, item_1_parameters),
  ...,
  F_J(y_iJ | theta_i, item_J_parameters);
  dependence_parameters
)
```

where `C_theta` may be the independence copula, a parametric copula, a factor copula construction, a vine copula, a testlet-specific copula, or a structured family selected under interpretability and identifiability constraints.

### 4.2 What IRTc is not allowed to assume too quickly

Because item responses are commonly dichotomous or ordinal, the project must not make a naive continuous-copula argument. Sklar's theorem gives unique copulas under continuous marginals, but observed item responses are often discrete. Therefore, IRTc must explicitly solve or work around the discrete-data issue.

Candidate resolutions to investigate:

1. **Latent-continuous response formulation:** Treat observed item categories as thresholds of latent continuous response variables and define copulas on the latent continuous scale.
2. **Exact rectangle-probability likelihood:** For ordinal or binary observed responses, compute category probabilities as copula rectangle differences.
3. **Bayesian data augmentation:** Introduce latent continuous variables consistent with observed response categories and sample or optimize over the augmented posterior.
4. **Parametric factor copula construction:** Use existing factor copula models for discrete item-response data as a starting point.
5. **Distributional transform or randomized transform:** Use only if the literature review supports it for the target inference problem.

No agent may claim that IRTc is "more mathematically sound" unless it specifies the response scale, margin definition, copula identification conditions, estimation procedure, and empirical evidence for the claim.

### 4.3 Conventional IRT as a special case

IRTc should test whether conventional models can be represented as special cases or close analogues:

- Rasch/1PL, 2PL, 3PL, graded response, partial credit, and generalized partial credit models as choices of item marginals plus conditional independence.
- Normal-ogive models as Gaussian latent-variable or BVN-linking special cases within factor copula constructions.
- Multidimensional IRT as structured latent trait dependence, possibly represented by Gaussian, t, Archimedean, vine, factor, or hierarchical copulas.
- Testlet and local-dependence models as structured deviations from the conditional product copula.

The research team must distinguish three levels:

1. **Exact equivalence:** Algebraically identical likelihood after parameter mapping.
2. **Approximation:** Similar ICCs or similar predictive behavior under scaling constants or asymptotic regimes.
3. **Analogy:** Conceptual but not mathematically equivalent.

---

## 5. Core research questions

### 5.1 Theory questions

1. Can a copula-first formulation recover local-independence IRT as the independence-copula case?
2. Which conventional IRT models are exact special cases of factor copula models, and which are only approximations?
3. How should item difficulty, discrimination, guessing, slipping, and thresholds be interpreted when dependence is no longer Gaussian or product-form?
4. What identifiability conditions are required for dichotomous and ordinal item-response data?
5. How does the choice of copula family alter item information, test information, ability estimates, standard errors, and classification decisions?
6. Can tail dependence be given a psychometric interpretation, such as items jointly failing among low-ability examinees or jointly succeeding among high-ability examinees beyond conventional model expectations?
7. Can asymmetric copulas model items that discriminate differently in lower versus upper regions of the latent trait?
8. Does IRTc preserve any Rasch-style invariance or specific objectivity under restricted copula families, or does it necessarily trade that property for flexibility?
9. How should differential item functioning (DIF), group invariance, fairness, and measurement equivalence be redefined under IRTc?
10. What is the relationship among IRTc, local dependence diagnostics, testlet response theory, MIRT, graphical models, latent class IRT, and item bundles?

### 5.2 Empirical questions

1. On which real datasets does IRTc improve held-out response prediction relative to Rasch/2PL/3PL/GRM/GPCM/MIRT baselines?
2. On which datasets does IRTc improve global or local fit while maintaining interpretable item parameters?
3. Does IRTc primarily improve fit for datasets with known or suspected local dependence, testlets, item bundles, speededness, response times, or multidimensionality?
4. Are improvements robust across train/test splits, sample sizes, missingness patterns, scoring recodes, and copula family choices?
5. Are the additional dependence parameters stable, interpretable, and estimable at realistic educational-testing sample sizes?
6. Does model-selection risk increase enough to erase performance gains under cross-validation or held-out log loss?
7. Can IRTc diagnostics identify item clusters, local-dependence structures, tail anomalies, or response-process artifacts that conventional residual diagnostics miss?

### 5.3 Product and workflow questions

1. Can dataimago expose the entire IRTc pipeline as a generated web application with reproducible data endpoints, model APIs, experiment logs, and reports?
2. Can AI agents safely run auto-research loops without corrupting raw data, changing evaluation rules, or hallucinating citations?
3. Can the system produce reports that are useful to psychometricians rather than merely visually polished?
4. Can the framework generalize from IRTc to future psychometric methodology projects?

---

## 6. Model ladder

The project should implement models in a ladder from simplest to most flexible. Do not jump directly to the most complex model.

### Level 0: Baseline conventional IRT

Purpose: establish reproducible comparisons.

Models:

- Rasch/1PL.
- 2PL.
- 3PL where appropriate.
- Graded response model for ordered categories.
- Partial credit and generalized partial credit models.
- MIRT and bi-factor baselines where dimensions or testlets are plausible.

Tools:

- `mirt`.
- `TAM`.
- Optional: `ltm`, `eRm`, `brms`, `Stan`, `PyMC`, or custom likelihoods only when justified.

### Level 1: IRTc product-copula wrapper

Purpose: show that IRTc can represent conventional local-independence IRT through a product-copula dependence layer.

Deliverable:

- A formal model spec and code path where the copula is fixed to independence and results match baseline models within numerical tolerance, when model assumptions align.

Acceptance test:

- Parameter estimates, log likelihoods, and predicted probabilities agree with baseline implementation or differences are explained and documented.

### Level 2: One-factor copula IRT

Purpose: reproduce and extend existing factor copula models for item-response data.

Candidate families:

- Gaussian/BVN copula.
- Student t copula.
- Frank copula.
- Clayton and rotated Clayton.
- Gumbel and rotated Gumbel.
- Joe and BB families if supported and interpretable.

Deliverables:

- Reproduction of at least one existing factor copula example from literature or package documentation.
- Simulations showing parameter recovery under known copula families.
- Comparison against normal-ogive/MIRT baselines.

### Level 3: Local-dependence IRTc

Purpose: model residual item dependence conditional on latent ability.

Structures:

- Testlet-specific copulas.
- Item-bundle copulas.
- Sparse residual vine copulas.
- Factor tree copula residuals.
- Conditional pair-copula structures selected under constraints.

Deliverables:

- Direct comparison with local-dependence diagnostics such as Q3-style residuals and limited-information fit statistics.
- Sensitivity to item clustering assumptions.
- Visual diagnostics showing where dependence concentrates.

### Level 4: Structured multidimensional IRTc

Purpose: model multiple latent traits, group-specific factors, and hierarchical dependence.

Structures:

- Bi-factor copula models.
- Second-order copula models.
- Factor tree copula models.
- Domain/testlet hierarchical models.

Deliverables:

- Comparison with MIRT, bi-factor, and two-tier baselines.
- Evaluation of whether copula families provide gains beyond simply adding dimensions.

### Level 5: Extended IRTc

Purpose: explore high-value extensions after Levels 0-4 are stable.

Extensions:

- Response time plus accuracy joint models.
- Longitudinal item-response dependence.
- Computer adaptive testing implications.
- DIF and group-specific dependence structures.
- Mixture copula IRT for latent classes or strategy groups.
- Hybrid knowledge-space and copula IRT models.

---

## 7. Research work packages

### WP1: Literature and claim foundation

Goal: create a non-hallucinated, citation-backed research base.

Tasks:

- Build a Zotero/BibTeX/library database with PDFs, abstracts, DOIs, and source URLs.
- Create a `claims.yaml` ledger where every material claim is labeled as `established`, `inference`, `hypothesis`, `speculation`, or `unverified`.
- Separate primary sources from secondary explanations.
- Prioritize peer-reviewed psychometrics, statistics, and copula-dependence literature.
- Include classic sources: Lord, Novick, Rasch, Birnbaum, Samejima, Bock, Yen, Maydeu-Olivares, Joe, Sklar, Nelsen, Embrechts, and contemporary factor-copula item-response papers.
- Include software documentation only for implementation facts, not theoretical claims.

Outputs:

- `research/literature/bibliography.bib`.
- `research/literature/claims.yaml`.
- `research/literature/lit_matrix.parquet`.
- `wiki/theory/irtc_literature_review.md`.
- `wiki/theory/discrete_copula_cautions.md`.

Quality gates:

- No report paragraph may contain an empirical or historical claim without at least one source ID.
- No AI-generated citation is accepted until verified by DOI, publisher page, arXiv, CRAN, official docs, or library metadata.
- A separate auditor agent must inspect every final report claim.

### WP2: Mathematical specification

Goal: produce a formal theory document for IRTc.

Tasks:

- Define notation for persons, items, response categories, latent traits, item marginals, copula families, and dependence parameters.
- Define conditional and marginal likelihoods for binary and ordinal items.
- Specify where the copula is placed: among observed item responses conditional on theta, between latent response variables and theta, among latent dimensions, among residuals, or among testlet-specific effects.
- Derive category probabilities using rectangle probabilities for discrete outcomes.
- Derive special-case mappings to conventional IRT where possible.
- State identifiability assumptions and estimation constraints.
- Define psychometric interpretations of tail dependence, asymmetry, and copula parameters.
- Define when a copula parameter is an estimand of substantive interest versus a nuisance parameter for fit.

Outputs:

- `wiki/theory/irtc_formal_spec.md`.
- `wiki/theory/special_cases.md`.
- `wiki/theory/identifiability.md`.
- `wiki/theory/parameter_interpretation.md`.

Quality gates:

- Every theorem-like statement gets proof, citation, or `conjecture` label.
- Every discrete-data likelihood states the exact probability calculation.
- Every model has a simulation recipe before being used on IRW data.

### WP3: Software implementation

Goal: implement a testable, modular model engine.

Tasks:

- Wrap established packages first: `mirt`, `TAM`, `FactorCopula`.
- Add custom likelihood code only after package baselines are reproducible.
- Standardize model inputs and outputs in a model-result schema.
- Store all fits with versions, seeds, optimizer settings, convergence diagnostics, and warnings.
- Implement exact simulations for each model family.
- Implement parameter recovery tests.
- Implement prediction APIs for held-out responses.

Outputs:

- `packages/irtc-core/`: TypeScript schemas, model metadata, API contracts.
- `engines/R/`: R package or script layer using `renv`.
- `engines/python/`: optional Python layer for simulations, diagnostics, or Bayesian workflows.
- `tests/model_equivalence/`.
- `tests/parameter_recovery/`.
- `tests/predictive_checks/`.

Quality gates:

- Every model has unit tests and smoke tests.
- Every model fit returns convergence status and warnings.
- No failed or nonconverged fit is silently included in model comparisons.
- Baselines must run before copula extensions are scored.

### WP4: IRW data pipeline

Goal: acquire, harmonize, document, and version real item-response datasets.

Tasks:

- Use `irw` and/or IRW API access through authenticated Redivis workflows where available.
- Create data cards for each dataset: source, license, sample size, item count, response type, missingness, scoring, constructs, metadata, known grouping/testlet information, and preprocessing choices.
- Select a tiered benchmark set: small, medium, large; dichotomous, polytomous; likely unidimensional, likely multidimensional; low and high suspected local dependence.
- Do not mutate raw IRW downloads.
- Convert datasets to common long and wide formats.
- Generate reproducible train/validation/test splits at person-response or person-vector level, depending on the evaluation.

Data zones:

```text
data/
  raw/        # immutable downloads or source snapshots
  bronze/     # parsed but minimally transformed
  silver/     # harmonized item/person/response schemas
  gold/       # benchmark-ready matrices and splits
  manifests/  # hashes, licenses, provenance, transformations
```

Core schemas:

```text
person_id: string
item_id: string
response: integer | numeric | string
score: numeric | null
response_category: string | null
time: numeric | null
dataset_id: string
construct: string | null
item_group: string | null
metadata: json
```

Outputs:

- `data/manifests/datasets.yaml`.
- `data/manifests/splits.yaml`.
- `data/cards/<dataset_id>.md`.
- `apps/template/src/app/api/data/irw/...` producer endpoints.

Quality gates:

- Every dataset has provenance and license fields before use.
- Every transformation is logged with input hash and output hash.
- Any recoding of responses is documented and reversible when possible.
- Missingness handling is explicitly recorded.

### WP5: Benchmarking and sensitivity analysis

Goal: compare IRTc against conventional frameworks under fair, reproducible conditions.

Benchmark families:

1. **Simulation benchmarks:** known data-generating processes.
2. **Recovery benchmarks:** estimate known parameters from simulated data.
3. **Predictive benchmarks:** held-out response prediction on real data.
4. **Fit benchmarks:** log likelihood, AIC/BIC, M2, residual dependence, posterior predictive checks.
5. **Interpretability benchmarks:** stability and usefulness of parameters and diagnostics.
6. **Robustness benchmarks:** sensitivity to sample size, missingness, item count, family selection, optimization starts, and scoring choices.
7. **Compute benchmarks:** runtime, memory, convergence failures, and scalability.

Metrics:

- Held-out log loss.
- Held-out Brier score for binary items.
- Accuracy only as a secondary, threshold-dependent metric.
- Marginal log likelihood or approximate marginal log likelihood.
- AIC, BIC, SABIC where valid.
- WAIC/LOO only for Bayesian models where diagnostics pass.
- M2 or limited-information fit statistics where supported.
- Residual correlation/Q3-style diagnostics.
- Calibration curves by ability strata.
- Parameter recovery RMSE and bias.
- Rank-order correlation of ability estimates across models.
- Stability of item parameters across splits.
- Runtime and convergence rate.

Outputs:

- `experiments/registry.yaml`.
- `experiments/results.parquet`.
- `reports/benchmark_summary.qmd`.
- `reports/benchmark_summary.html`.
- `apps/template/src/app/benchmarks/...` dashboard pages.

Quality gates:

- Evaluation scripts are immutable during an auto-research run.
- Model comparison uses held-out data, not only in-sample fit.
- The best model must beat a complexity-adjusted or held-out baseline, not merely add parameters.
- Sensitivity analyses must run before any claim of superiority.

### WP6: Reporting and synthesis

Goal: produce expert-grade research outputs.

Report types:

- Research memo: literature synthesis and theory updates.
- Methods note: formal model definition and estimation details.
- Data report: IRW dataset provenance, transformations, and benchmark suitability.
- Experiment report: model comparisons, diagnostics, and limitations.
- Executive dashboard: readable summary for non-specialist stakeholders.
- Reproducibility appendix: code, seeds, versions, hashes, and environment.

Outputs:

- `reports/theory/irtc_formal_basis.md`.
- `reports/benchmarks/irtc_vs_baselines.md`.
- `reports/data/irw_benchmark_data_cards.md`.
- `reports/audit/claim_audit.md`.
- `reports/release/irtc_whitepaper_v0.md`.

Quality gates:

- Claims are stratified as `established`, `supported by this benchmark`, `suggestive`, or `speculative`.
- Every plot links to the data and code that generated it.
- Every table includes model version, dataset version, split ID, and seed.
- Reports distinguish failure cases from success cases.

---

## 8. Suggested generated repository layout

After using dataimago to generate the IRTc application, target a layout like this:

```text
irtc-lab/
  README.md
  package.json
  pnpm-workspace.yaml
  turbo.json

  apps/
    web/                         # dataimago-generated Next.js app
      src/app/
        page.tsx
        datasets/
        experiments/
        models/
        reports/
        api/
          discover/
          data/[endpoint]/[[...params]]/
          wiki/[...path]/
          scheduled/[task]/
          irtc/
            datasets/
            fit/
            compare/
            reports/
      src/components/
      src/lib/

  packages/
    irtc-core/                   # TypeScript schemas and shared model contracts
      src/schemas/
      src/metrics/
      src/provenance/
    irtc-ui/                     # optional report/dashboard components
    mcp-tools/                   # project-specific MCP tools if not inherited

  engines/
    R/
      renv.lock
      DESCRIPTION
      R/
        fit_mirt.R
        fit_tam.R
        fit_factorcopula.R
        simulate_irtc.R
        compare_models.R
      tests/
    python/
      pyproject.toml
      src/irtc/
      tests/

  data/
    raw/
    bronze/
    silver/
    gold/
    manifests/
    cards/

  research/
    literature/
      bibliography.bib
      claims.yaml
      lit_matrix.parquet
    theory/
    notes/

  experiments/
    registry.yaml
    runs/
      <run_id>/
        config.yaml
        metrics.json
        logs.txt
        artifacts/

  reports/
    theory/
    data/
    benchmarks/
    audit/
    release/

  wiki/
    theory/
    methods/
    data/
    experiments/
    decisions/
    patterns/
```

---

## 9. API and producer-driver surface

Expose model and data artifacts through stable endpoints. Example logical endpoints:

```text
GET  /api/discover
GET  /api/data/irw/datasets
GET  /api/data/irw/datasets/:dataset_id/metadata
GET  /api/data/irw/datasets/:dataset_id/responses
GET  /api/data/benchmarks
GET  /api/data/experiments/:run_id
POST /api/irtc/fit
POST /api/irtc/compare
POST /api/irtc/simulate
POST /api/irtc/report
GET  /api/wiki/:path
POST /api/scheduled/:task
```

Producer drivers should be responsible for:

- IRW dataset listing and metadata retrieval.
- Benchmark split retrieval.
- Model-result loading.
- Report artifact loading.
- Claim-ledger search.
- Experiment registry search.

Do not allow arbitrary AI-generated code execution through public API routes. Tool actions must be schema-validated and restricted to known commands or queued jobs.

---

## 10. MCP tool plan

Define MCP tools around auditable actions rather than vague research commands.

Recommended tools:

```text
search_literature(query, constraints) -> source_candidates
verify_source(source_candidate) -> verified_source_record
extract_claims(source_record) -> claim_candidates
audit_claim(claim_id) -> audit_result
list_irw_datasets(filters) -> dataset_candidates
ingest_irw_dataset(dataset_id, version, auth_profile) -> dataset_manifest
create_benchmark_split(dataset_id, split_config) -> split_manifest
fit_baseline_irt(model_config, dataset_split) -> model_result
fit_copula_irt(model_config, dataset_split) -> model_result
simulate_irtc(simulation_config) -> simulation_result
compare_models(comparison_config) -> comparison_report
generate_quarto_report(report_config) -> report_artifact
run_claim_audit(report_path) -> audit_report
```

Each tool must return structured data with:

```text
status: success | failure | partial
inputs_hash: string
outputs_hash: string
warnings: string[]
errors: string[]
artifacts: path[]
source_ids: string[]
```

---

## 11. Auto-research loop for IRTc

The auto-research system should adapt the Karpathy-loop idea to research methodology work. The loop is not simply "let agents research." It is a controlled system with fixed evaluation rules.

### 11.1 Editable surfaces

Agents may propose changes to:

- Model family selection.
- Copula family candidate lists.
- Optimizer settings.
- Priors or regularization settings where applicable.
- Simulation designs.
- Data preprocessing variants, if declared before fitting.
- Diagnostic plots.
- Report templates.
- Claim extraction and audit prompts.
- Dashboard components.

### 11.2 Frozen surfaces during a run

Agents may not change these inside an autonomous loop:

- Raw data.
- Train/validation/test split definitions.
- Primary evaluation metrics.
- Acceptance thresholds.
- Baseline model definitions.
- Claim-verification rules.
- Source whitelist/blacklist decisions.
- Human-approved research charter.

### 11.3 Setup phase

Human plus planning agent:

1. Choose research question and benchmark scope.
2. Select datasets and simulation scenarios.
3. Freeze metrics and acceptance thresholds.
4. Freeze baseline models.
5. Define editable model/config/report surfaces.
6. Generate a baseline run.
7. Generate a claim-audit checklist.
8. Approve the experiment manifest.

### 11.4 Autonomous phase

Agent swarm:

1. Mutate one controlled element.
2. Run tests or fit models.
3. Score against frozen metrics.
4. Keep change only if it improves the score without violating gates.
5. Log the attempt, including failure modes.
6. Repeat until stopping criteria are met.

Stopping criteria:

- Maximum number of experiments.
- Maximum compute budget.
- No improvement over N attempts.
- Convergence failure rate above threshold.
- Claim-audit failure.
- Human review required because model class changed.

### 11.5 Debrief phase

Human plus synthesis agent:

1. Compare before/after metrics.
2. Inspect rejected and accepted changes.
3. Run sensitivity analyses.
4. Run claim audit.
5. Produce release report.
6. Update the research wiki and decision log.

### 11.6 Example scoring function

Use a weighted score only after individual metrics are inspected:

```text
score =
  0.30 * heldout_logloss_gain_vs_best_baseline
+ 0.20 * calibration_gain
+ 0.15 * residual_dependence_reduction
+ 0.10 * parameter_stability
+ 0.10 * interpretability_rubric
+ 0.10 * compute_feasibility
+ 0.05 * report_audit_pass_rate
- penalties_for_nonconvergence
- penalties_for_unverified_claims
- penalties_for_unjustified_complexity
```

Do not let a single composite score hide major regressions.

---

## 12. Agent roles and labor distribution

### 12.1 Principal investigator agent

Responsibilities:

- Maintain the research charter.
- Resolve conflicts among agents.
- Approve model-ladder progression.
- Decide whether evidence supports claims.
- Maintain `wiki/decisions/`.

Cannot:

- Invent citations.
- Override failed statistical diagnostics without documentation.

### 12.2 Literature curator agent

Responsibilities:

- Search, retrieve, and catalog sources.
- Extract claims and map them to source passages.
- Maintain bibliography and literature matrix.
- Mark source quality: peer-reviewed, preprint, software docs, blog, historical primary source, secondary exposition.

Outputs:

- `bibliography.bib`.
- `lit_matrix.parquet`.
- `claims.yaml` entries.

### 12.3 Theory agent

Responsibilities:

- Formalize IRTc model classes.
- Derive likelihoods and special cases.
- State assumptions and identifiability constraints.
- Propose simulation designs.

Outputs:

- Formal specs and proof sketches.
- Model diagrams.
- Edge-case warnings.

### 12.4 Data steward agent

Responsibilities:

- Ingest IRW and other datasets.
- Preserve provenance, licenses, and hashes.
- Create data cards.
- Prepare benchmark splits.
- Document missingness and scoring transformations.

Cannot:

- Drop observations or recode items without recording the operation.

### 12.5 Statistical engineering agent

Responsibilities:

- Implement model wrappers.
- Run simulations.
- Fit baselines and IRTc models.
- Record convergence warnings.
- Build reproducible result objects.

Outputs:

- Model results.
- Unit tests.
- Parameter recovery reports.

### 12.6 Evaluation agent

Responsibilities:

- Own metrics and benchmark scripts.
- Prevent metric drift during auto-research loops.
- Run held-out comparisons and sensitivity analyses.
- Flag overfitting and complexity inflation.

Outputs:

- `comparison_report.json`.
- `benchmark_summary.qmd`.

### 12.7 Web application agent

Responsibilities:

- Implement dataimago API routes and dashboard pages.
- Expose producer-driver outputs.
- Build report navigation and experiment dashboards.
- Keep UI aligned with dataimago design conventions.

Outputs:

- Next.js pages and API handlers.
- Dashboard components.
- Integration tests.

### 12.8 Documentation and report agent

Responsibilities:

- Turn research artifacts into readable documentation.
- Maintain wiki pages.
- Generate Quarto/Markdown/HTML reports.
- Distinguish established evidence from speculation.

Outputs:

- Release reports.
- Wiki updates.
- Executive summaries.

### 12.9 Replication and audit agent

Responsibilities:

- Re-run selected results from scratch.
- Audit claims and citations.
- Check reproducibility of tables and plots.
- Verify that no benchmark changed mid-run.

Outputs:

- `audit/claim_audit.md`.
- `audit/reproducibility_audit.md`.
- `audit/model_fit_audit.md`.

---

## 13. Data strategy with IRW

IRW is a strong candidate resource because it is open, harmonized, large, and focused on cross-classified item response data. Use it for comparative and sensitivity analyses, but avoid assuming every IRW dataset is psychometrically appropriate for every IRTc model.

### 13.1 Dataset selection criteria

Select datasets that vary across:

- Response type: dichotomous, ordinal/polytomous, continuous if relevant.
- Person count and item count.
- Construct domain: education, cognition, personality, political/social items, etc.
- Suspected dimensionality.
- Presence of item groups, subscales, testlets, passages, forms, or bundles.
- Missingness patterns.
- Availability of metadata and scoring documentation.
- License and provenance clarity.

### 13.2 Benchmark tiers

Tier A: smoke-test datasets

- Small enough to fit rapidly.
- Used for integration tests and report-template checks.

Tier B: primary benchmarks

- Large enough to compare conventional IRT and IRTc fairly.
- Clear scoring and metadata.
- Include both likely local-independence-friendly and local-dependence-heavy datasets.

Tier C: stress-test datasets

- Larger, higher-dimensional, more missingness, more items, or more categories.
- Used for scalability and robustness.

### 13.3 Required data cards

Each dataset must have a data card with:

```yaml
dataset_id: string
source_name: string
source_url: string
irw_version: string | null
license: string
provenance_summary: string
construct: string | null
response_type: dichotomous | ordinal | nominal | continuous | mixed
n_persons: integer
n_items: integer
n_responses: integer
missingness_rate: numeric
scoring_rules: string
item_group_variables: string[]
known_limitations: string[]
preprocessing_steps: string[]
raw_hash: string
silver_hash: string
gold_hash: string
created_at: date
created_by: string
```

---

## 14. Comparative analysis design

### 14.1 Baselines

At minimum:

- Rasch/1PL.
- 2PL.
- GRM or GPCM for ordinal data.
- MIRT where dimensionality evidence supports it.
- Bi-factor/testlet models where item grouping exists.
- Existing factor copula models through `FactorCopula`.

### 14.2 Candidate IRTc models

Start with:

- Product-copula IRTc wrapper.
- Gaussian/BVN factor copula.
- t factor copula.
- Frank factor copula.
- Clayton/Gumbel and rotated variants for tail asymmetry.
- Structured bi-factor and second-order copula models.
- Factor tree copula residual structures.

Add more families only after clear diagnostic need.

### 14.3 Fairness of comparison

Rules:

- Match data preprocessing across models.
- Use the same train/test splits.
- Use the same item inclusion criteria.
- Report parameter count or effective complexity.
- Report failed fits.
- Compare against stronger baselines before claiming IRTc gains.
- Include simple baselines; do not compare only against weak models.

### 14.4 Sensitivity analyses

Run sensitivity on:

- Copula family set.
- Starting values.
- Number of quadrature points or integration method.
- Sample size subsampling.
- Item count subsampling.
- Missingness handling.
- Category collapsing.
- Group/testlet definitions.
- Person-split versus response-cell split evaluation.
- Optimizer and convergence thresholds.

---

## 15. Claim management and anti-hallucination protocol

Every AI-produced research claim must be managed through a claim ledger.

### 15.1 Claim schema

```yaml
claim_id: C0001
claim_text: "Local independence implies conditional factorization of item responses given theta."
claim_type: established | inference | hypothesis | speculation | unverified
source_ids: [S0001, S0002]
source_quality: peer_reviewed | book | software_docs | official_docs | preprint | blog | user_context
scope: theory | history | implementation | empirical_result | workflow
risk_level: low | medium | high
verified_by: agent_id
verification_date: date
notes: string
```

### 15.2 Claim rules

- `unverified` claims cannot appear in release reports except in an explicit open-questions section.
- Blog posts can motivate workflows but cannot support technical psychometric theory unless they cite primary sources.
- Software docs can support package capabilities, not statistical truth.
- User-provided speculative text can motivate hypotheses but cannot be cited as external evidence.
- Every final report must include a limitations section.
- Every source must be stored with enough metadata to retrieve it again.

### 15.3 Citation audit

Audit questions:

1. Does the source actually support the claim?
2. Is the source primary, secondary, software documentation, or informal commentary?
3. Is the claim stronger than the evidence?
4. Is there contradictory evidence?
5. Is the citation stale for software, datasets, or current package capabilities?
6. Does the report mark speculation clearly?

---

## 16. Experiment registry

Every experiment must be registered before it runs.

Example:

```yaml
run_id: exp_2026_05_13_001
research_question: "Does a one-factor t copula improve held-out prediction over 2PL on dataset X?"
dataset_id: irw_dataset_x
split_id: split_001
models:
  - baseline_2pl_mirt
  - irtc_one_factor_t
metrics:
  primary: heldout_logloss
  secondary:
    - brier_score
    - q3_residual_summary
    - runtime_seconds
acceptance:
  min_logloss_gain: 0.005
  max_convergence_failure_rate: 0.05
  require_claim_audit: true
frozen_files:
  - data/manifests/splits.yaml
  - experiments/eval_scripts/heldout_logloss.R
editable_files:
  - engines/R/R/fit_factorcopula.R
  - experiments/configs/copula_family_grid.yaml
seed: 20260513
status: planned | running | complete | failed | rejected
```

---

## 17. Reporting products

### 17.1 Internal reports

- `theory_status.md`: what is formally established, what remains conjectural.
- `implementation_status.md`: what is implemented, tested, failing, or blocked.
- `data_inventory.md`: usable datasets and exclusions.
- `experiment_debrief.md`: accepted/rejected changes and why.
- `audit_report.md`: citation and reproducibility checks.

### 17.2 External-facing reports

- `IRTc_whitepaper_v0.md`: theory and motivation.
- `IRTc_benchmark_report_v0.md`: empirical comparisons.
- `IRTc_data_appendix_v0.md`: dataset provenance and transformations.
- `IRTc_methods_appendix_v0.md`: estimation and diagnostics.
- `IRTc_limitations_v0.md`: where IRTc failed or is not yet justified.

### 17.3 Dashboard views

- Dataset browser.
- Model fit explorer.
- Copula-family comparison view.
- Local dependence heatmap.
- Tail-dependence diagnostic view.
- Ability-estimate comparison view.
- Experiment timeline.
- Claim-audit dashboard.

---

## 18. First milestone plan

### Milestone 0: Scaffold

Deliver:

- Generated dataimago IRTc app.
- Repo layout.
- `renv` and/or package environment.
- API skeleton.
- Claim ledger skeleton.
- Experiment registry skeleton.

Done when:

- App runs locally.
- `/api/discover` lists IRTc tools and data endpoints.
- One smoke-test report renders.

### Milestone 1: Baselines

Deliver:

- One clean simulated binary IRT dataset.
- One clean simulated ordinal IRT dataset.
- Baseline Rasch/2PL/GRM fits.
- Equivalence tests for product-copula wrapper if implemented.

Done when:

- Conventional baselines reproduce expected parameter behavior.
- Model-result schema is stable.

### Milestone 2: Existing copula reproduction

Deliver:

- `FactorCopula` installation and smoke tests.
- Reproduction of a documented factor-copula example.
- Simulation-based parameter recovery for at least one copula family.

Done when:

- Copula model fit is reproducible and audited.

### Milestone 3: IRW ingestion

Deliver:

- Authenticated or documented IRW access route.
- At least three IRW data cards.
- Long/wide harmonized formats.
- Fixed splits.

Done when:

- Baseline and copula models can run on at least one IRW dataset.

### Milestone 4: First benchmark report

Deliver:

- Conventional baselines vs one-factor copula models.
- Held-out prediction and fit diagnostics.
- Sensitivity analysis on copula family.
- Claim audit.

Done when:

- Report makes no unsupported superiority claims.
- Failure modes are documented.

### Milestone 5: Auto-research loop

Deliver:

- Controlled mutation loop over copula family, optimizer config, and report diagnostics.
- Frozen evaluation metrics.
- Accepted/rejected experiment log.
- Debrief report.

Done when:

- At least one autonomous loop improves a predefined score without breaking audit gates, or the system clearly documents why it failed.

---

## 19. Key risks and mitigations

### Risk: Copula non-identifiability for discrete outcomes

Mitigation:

- Treat this as a central theory work package.
- Use latent-continuous formulations, rectangle likelihoods, or Bayesian augmentation.
- Avoid naive claims based on continuous Sklar uniqueness.

### Risk: Extra parameters improve in-sample fit but not prediction

Mitigation:

- Use held-out prediction and complexity penalties.
- Require stronger baselines.
- Report failed generalization.

### Risk: Agents hallucinate literature or overstate novelty

Mitigation:

- Claim ledger.
- Source verification.
- Separate auditor agent.
- No-source-no-claim rule.

### Risk: IRW metadata are insufficient for intended models

Mitigation:

- Data cards.
- Exclusion criteria.
- Use only datasets with adequate metadata for model-specific claims.

### Risk: Computation becomes too expensive

Mitigation:

- Laddered model development.
- Smoke tests and tiered datasets.
- Runtime metrics.
- Early rejection of unstable models.

### Risk: Flexible dependence damages psychometric interpretability

Mitigation:

- Interpretability rubric.
- Parameter stability checks.
- Expert-review-ready plots.
- Explicit tradeoff analysis.

---

## 20. Acceptance criteria for the overall IRTc project

IRTc should be considered promising only if it satisfies most of these criteria:

1. The theory document clearly defines the model classes and discrete-data assumptions.
2. Conventional IRT appears as an exact or well-characterized special case where claimed.
3. Baseline and copula models are compared under fair splits and metrics.
4. At least some IRTc models improve held-out prediction, residual dependence diagnostics, or interpretability on datasets where conventional assumptions are plausibly violated.
5. Gains are robust across sensitivity analyses.
6. The additional parameters are stable enough to interpret.
7. Reports are fully reproducible from data and code.
8. Every material claim is citation-backed or clearly marked as speculative.
9. The web app provides a usable inspection interface, not just static files.
10. Failure cases are documented and used to refine the model ladder.

IRTc should be considered not yet supported if it only improves in-sample likelihood, fails to converge frequently, cannot be interpreted, lacks identifiability clarity, or wins only against weak baselines.

---

## 21. First batch of concrete tasks for agents

1. Create `research/literature/bibliography.bib` with the source anchors above.
2. Create `research/literature/claims.yaml` and enter the user-provided conjecture as a `hypothesis`, not an established claim.
3. Write `wiki/theory/discrete_copula_cautions.md` before any model implementation claims.
4. Generate simulation code for binary 2PL and ordinal GRM data.
5. Fit baseline models with `mirt` and/or `TAM`.
6. Install and smoke-test `FactorCopula`.
7. Reproduce one documented `FactorCopula` workflow.
8. Define the model-result JSON schema.
9. Define the IRW data-card schema.
10. Use `irw` to list available datasets after Redivis authentication is configured.
11. Select three initial IRW datasets: one smoke-test, one primary benchmark, one stress-test.
12. Build `/api/discover` entries for data, model, comparison, report, and audit tools.
13. Build a first Quarto/Markdown report from one simulated-data benchmark.
14. Run a claim audit on that report.
15. Only then start an autonomous model-improvement loop.

---

## 22. Minimal report outline for the first IRTc whitepaper

```text
# IRTc: Copula-Based Item Response Theory

1. Abstract
2. Motivation
3. Historical framing: from empirical curves and normal ogives to dependence modeling
4. Conventional IRT assumptions
5. Copulas and Sklar's theorem
6. The discrete response problem
7. IRTc model family
8. Conventional IRT as special cases or approximations
9. Estimation strategies
10. Simulations
11. IRW benchmark datasets
12. Results
13. Diagnostics and interpretability
14. Sensitivity analyses
15. Limitations
16. Future work
17. Reproducibility appendix
18. Claim audit appendix
```

---

## 23. Final instruction to all AI agents

The point of this project is not to produce a persuasive narrative that copula-based IRT is automatically better. The point is to build a research machine that can discover, test, falsify, refine, and report what is actually true.

Treat IRTc as a serious candidate framework. Also treat every attractive claim as suspect until it survives source verification, mathematical specification, implementation tests, benchmark comparison, sensitivity analysis, and audit.

