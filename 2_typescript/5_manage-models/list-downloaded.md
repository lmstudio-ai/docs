---
title: List Local Models
description: APIs to list the available models in a given local environment
---

You can iterate through locally available models using the `listLocalModels` method. This method lives under the `system` namespace of the `LMStudioClient` object.

## Available Model on the Local Machine

This will give you results equivalent to using [`lms ls`](../../cli/ls) in the CLI.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        // TODO: @ryan
```

Learn more about `client.system` namespace in the [System API Reference](../api-reference/system-namespace).