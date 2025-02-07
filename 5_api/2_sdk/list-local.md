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

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio as lm

        with lm.Client() as client:
          downloaded = lm.system.list_downloaded_models()

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        // TODO

```
