---
title: Decisions
description: Answer typed questions with a decision model.
index: 7
api_info:
  method: POST
---

- Method: `POST`
- See OpenAI docs: [Decisions guide](https://developers.openai.com/api/docs/guides/decisions) and [API reference](https://developers.openai.com/api/reference/resources/decisions/methods/create)

Requires a [loaded decision model](/docs/developer/rest/load), not a regular chat model.

##### Python example (Requires OpenAI Python 3.26.0+)

```python
from openai import OpenAI
client = OpenAI(base_url="http://localhost:1234/v1", api_key="lm-studio")

decision = client.decisions.create(
  model="model-identifier",
  input="I was charged twice.",
  questions=[
    {"type": "predicate", "name": "angry", "instructions": "Is the customer angry?"}
  ],
)

print(decision.answers)
```
