---
title: Tokenization
description: Tokenize text using a model's tokenizer
---

Explanation explanation explanation explanation explanation explanation explanation.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()
        # TODO

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio as lm

        with lm.Client() as client:
          llm = lm.llm.get()
          # TODO

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.getAny();
        // TODO

```
