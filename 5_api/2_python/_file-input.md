---
title: File Input
description: Add files to the input of the model
---

Explanation explanation explanation explanation explanation explanation explanation.
TODO leaving this private until we get confirmation general file input (RAG) will be in 1.0.0

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        file_handle = lm.add_temp_file()

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            file_handle = client.add_temp_file()

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        // TODO

```
