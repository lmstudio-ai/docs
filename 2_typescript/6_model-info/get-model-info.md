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
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const model = await client.llm.model();

        const model_info = await model.getInfo();
```
