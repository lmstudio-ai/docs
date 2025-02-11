---
title: List Loaded Models
description: Query which models are currently loaded
---

Explanation explanation explanation explanation explanation explanation explanation.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        downloaded = lm.list_loaded_models()
        llm_only = lm.list_loaded_models("llm")
        embedding_only = lm.list_loaded_models("embedding")

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio as lm
        import lmstudio

        with lmstudio.Client() as client:
            downloaded = client.list_loaded_models()
            llm_only = client.llm.list_loaded()
            embedding_only = client.embedding.list_loaded()

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        // TODO

```
