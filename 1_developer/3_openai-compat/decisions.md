---
title: Decisions
description: Answer typed questions with a decision model.
index: 7
api_info:
  method: POST
---

- Method: `POST`
- Endpoint: `/v1/decisions`
- See OpenAI docs: https://developers.openai.com/api/docs/guides/decisions

Use the identifier of a [loaded decision model](/docs/developer/rest/load), not a regular chat model.

Question types are `predicate` (probability that a condition is true), `choice` (select from `choices`), and `score` (rate against ordered `levels`). Responses contain an `answers` array in question order.

Streaming is not supported. Images must be inline base64 data URLs and require a model that supports image input.

##### cURL

```bash
curl http://localhost:1234/v1/decisions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "your-decision-model",
    "input": "I was charged twice.",
    "questions": [
      {"type": "predicate", "name": "angry", "instructions": "Is the customer angry?"}
    ]
  }'
```

##### Python example

Requires OpenAI Python SDK `3.26.0` or newer.

```python
from openai import OpenAI

client = OpenAI(base_url="http://localhost:1234/v1", api_key="lm-studio")

result = client.decisions.create(
    model="your-decision-model",
    input="I was charged twice.",
    questions=[
        {"type": "predicate", "name": "angry", "instructions": "Is the customer angry?"}
    ],
)
print(result.answers)
```

##### System One

`POST /v1/systemone` is also supported. This TypeSafe-compatible endpoint uses `state`, a question-ID-keyed `questions` object, and `noul` instead of `predicate`. Choice and score questions use `criteria` instead of `choices` and `levels`. Answers are keyed by question ID. It is a separate request/response format, not an alias for `/v1/decisions`.

```bash
curl http://localhost:1234/v1/systemone \
  -H "Content-Type: application/json" \
  -d '{
    "model": "your-decision-model",
    "state": "I was charged twice.",
    "questions": {
      "angry": {"type": "noul", "instructions": "Is the customer angry?"}
    }
  }'
```
