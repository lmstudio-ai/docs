---
title: Decisions
description: Answer typed questions with a decision model.
index: 7
api_info:
  method: POST
---

- Method: `POST`
- Requires a [loaded decision model](/docs/developer/rest/load), not a regular chat model
- Question types: `predicate`, `choice`, and `score`
- Streaming is not supported; images must be inline base64 data URLs and require an image-capable decision model
- Requires OpenAI Python SDK `3.26.0` or newer
- See OpenAI docs: https://developers.openai.com/api/docs/guides/decisions

##### Python example

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

### Supported payload parameters

See https://developers.openai.com/api/reference/resources/decisions/methods/create for parameter semantics.

```py
model
input
questions
```
