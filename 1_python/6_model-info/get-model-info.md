---
title: Get Model Info
description: Get information about the model
---

You can access general information and metadata about a model itself from a loaded
instance of that model.

Currently, the SDK exposes the model's default `identifier`
and the `path` used to [load it](/docs/api/sdk/load-model). In the below examples, `llm` can be replaced with an embedding model `emb`.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient()
        const llm = client.llm.model()

        model_info = llm.getInfo()
```
