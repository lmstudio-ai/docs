---
title: Get Model Info
description: Get information about the model
---

You can get some information about a given model using the SDK: the model's default `identifier`
and the `path` used to [load it](/docs/api/sdk/load-model). In the below examples, `llm` can be replaced with an embedding model `emb`.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()

        model_info = llm.get_info()

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()

            model_info = llm.get_info()

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.model();

        model_info = await llm.getInfo()
```
