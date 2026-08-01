# IRTc knowledge base — index

Seeded at M0 from the research charter, [`raw/background/IRTc.md`](../raw/background/IRTc.md)
(the authoritative source; these pages summarize and point, they do not replace it).
Project metadata lives in [`dataimago-spec.yaml`](../dataimago-spec.yaml).

## Pages

| Page | What it holds |
|---|---|
| [overview.md](overview.md) | Mission, the four parallel tracks, the founding conjecture (a hypothesis, never evidence) |
| [log.md](log.md) | Chronological activity, newest first |
| [theory/model-ladder.md](theory/model-ladder.md) | Levels 0–5, simplest → most flexible, with acceptance tests |
| [theory/discrete-copula-cautions.md](theory/discrete-copula-cautions.md) | Why discrete margins forbid naive Sklar arguments; candidate resolutions |
| [theory/level-1-product-copula-wrapper.md](theory/level-1-product-copula-wrapper.md) | The Level-1 formal spec: independence-copula IRTc ≡ mirt 2PL (claim C0004) |
| [methods/work-packages.md](methods/work-packages.md) | WP1–WP6: goals, outputs, quality gates |
| [methods/claim-ledger-protocol.md](methods/claim-ledger-protocol.md) | Claim schema, claim rules, citation-audit questions |
| [methods/auto-research-loop.md](methods/auto-research-loop.md) | Editable vs frozen surfaces, setup/autonomous/debrief phases, scoring |
| [methods/milestones.md](methods/milestones.md) | M0–M5 with done-when criteria; current status |
| [experiments/registry-protocol.md](experiments/registry-protocol.md) | Pre-registration rules; the registry lives at `../experiments/registry.yaml` |
| decisions/ | Decision records (empty until the first post-M0 decision) |

## Skeletons seeded at M0 (outside wiki/)

- `../research/literature/bibliography.bib` — the charter's §3.2 source anchors
- `../research/literature/claims.yaml` — claim ledger; C0001 is the founding conjecture, typed `hypothesis`
- `../experiments/registry.yaml` — experiment registry (empty; every experiment registers before it runs)

## Standing rules (charter §15, §23)

- No material claim without a source ID; no AI-generated citation accepted unverified.
- Software docs support capability claims only, never statistical truth.
- The founding Lord-era counterfactual generates research questions; it is not evidence.
- `raw/` is read-only: cite, summarize, link — never modify.
