---
title: List Local Models
description: Query which models are currently loaded
---

Explanation explanation explanation explanation explanation explanation explanation.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        downloaded = lm.list_downloaded_models()
        llm_only = lm.list_downloaded_models("llm")
        embedding_only = lm.list_downloaded_models("embedding")

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            downloaded = client.list_downloaded_models()
            llm_only = client.llm.list_downloaded()
            embedding_only = client.embedding.list_downloaded()

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        // TODO

```
