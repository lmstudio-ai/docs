---
title: Decisions (System One)
description: Answer typed questions using the Jev-compatible System One endpoint.
index: 2
api_info:
  method: POST
---

- Method: `POST`
- Endpoint: `/v1/systemone`
- See TypeSafe docs: https://docs.typesafe.ai/api

Use the identifier of a [loaded decision model](/docs/developer/rest/load), not a regular chat model.

Provide `state` and a `questions` object keyed by question ID. Question types are `noul` (probability that a condition is true), `choice` (select from a `criteria` object), and `score` (rate against an ordered `criteria` array). Responses contain an `answers` object keyed by question ID.

Images must be inline base64 data URLs and require a model that supports image input.

##### cURL

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

For the OpenAI-compatible request and response format, use [Decisions](/docs/developer/openai-compat/decisions).
