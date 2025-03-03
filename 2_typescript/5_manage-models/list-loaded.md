---
title: List Loaded Models
description: Query which models are currently loaded
---

You can iterate through models loaded into memory using the `listLoaded` method. This method lives under the `llm` and `embedding` namespaces of the `LMStudioClient` object.

## List Models Currently Loaded in Memory

This will give you results equivalent to using [`lms ps`](../../cli/ps) in the CLI.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();

        const llmOnly = await client.llm.listLoaded();
        const embeddingOnly = await client.embedding.listLoaded();
```

<!-- Learn more about `client.llm` namespace in the [API Reference](../api-reference/llm-namespace). -->
