---
title: Embedding
description: Generate text embeddings from input text
---

Explanation explanation explanation explanation explanation explanation explanation.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        model = lm.embedding_model()
        # TODO

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio as lm

        with lm.Client() as client:
          model = lm.embedding.get()
          # TODO

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const model = await client.embedding.getAny();
        // TODO

```
