# Claim ledger protocol

Charter §15. The ledger lives at `research/literature/claims.yaml`. Every material
AI-produced research claim passes through it.

## Schema (per claim)

```yaml
claim_id: C0001
claim_text: "…"
claim_type: established | inference | hypothesis | speculation | unverified
source_ids: [S0001, S0002]
source_quality: peer_reviewed | book | software_docs | official_docs | preprint | blog | user_context
scope: theory | history | implementation | empirical_result | workflow
risk_level: low | medium | high
verified_by: agent_id
verification_date: date
notes: "…"
```

## Rules

- `unverified` claims never appear in release reports except in an explicit open-questions
  section.
- Blog posts may motivate workflows; they cannot support psychometric theory unless they
  cite primary sources.
- Software docs support package **capabilities**, never statistical truth.
- User-provided speculative text motivates hypotheses; it is never external evidence
  (C0001 — the founding conjecture — is the canonical example).
- Every final report includes a limitations section.
- Every source is stored with enough metadata to retrieve it again.

## Citation-audit questions (asked of every final-report claim)

1. Does the source actually support the claim?
2. Primary, secondary, software documentation, or informal commentary?
3. Is the claim stronger than the evidence?
4. Is there contradictory evidence?
5. Is the citation stale (software, datasets, package capabilities)?
6. Is speculation clearly marked?
