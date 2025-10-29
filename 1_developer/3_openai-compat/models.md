---
title: List Models
description: List available models via the OpenAI-compatible endpoint.
index: 3
api_info:
  method: GET
---

- Method: `GET`
- Returns the models visible to the server. The list may include all downloaded models when Just‑In‑Time loading is enabled.

##### cURL

```bash
curl http://localhost:1234/v1/models
```
