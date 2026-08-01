# Data cards

One card per dataset, `<dataset_id>.md` with YAML front matter per charter §13.3.
A dataset without a completed card may not enter any benchmark.

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

Prose sections after the front matter: what the instrument measures, why the
dataset was selected (its benchmark tier and what it stresses), and anything a
psychometrician would want disclosed before trusting a model comparison on it.
