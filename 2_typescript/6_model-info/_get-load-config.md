---
title: Get Load Config
description: Get the load configuration of the model
---

LM Studio allows you to configure certain parameters when loading a model
[through the server UI](/docs/advanced/per-model) or [through the API](/docs/api/sdk/load-model).

You can retrieve the config with which a given model was loaded using the SDK. In the below examples, `llm` can be replaced with an embedding model `emb`.

```lms_protip
Context length is a special case that [has its own method](/docs/api/sdk/get-context-length).
```

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const model = await client.llm.model();

        loadConfig = await model.getLoadConfig()
```
