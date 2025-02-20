---
title: File Input
description: Add files to the input of the model
---

[//] # (TODO: Finalize and publish this once we're happy with the published API)

Explanation explanation explanation explanation explanation explanation explanation.

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
