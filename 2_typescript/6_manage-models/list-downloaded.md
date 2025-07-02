---
title: List Local Models
description: APIs to list the available models in a given local environment
---

You can iterate through locally available models using the `listLocalModels` method.

## Available Model on the Local Machine

`listLocalModels` lives under the `system` namespace of the `LMStudioClient` object.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";
        const client = new LMStudioClient();

        console.info(await client.system.listDownloadedModels());
```

This will give you results equivalent to using [`lms ls`](../../cli/ls) in the CLI.

### Example output:

```json
[
  {
    "type": "llm",
    "modelKey": "qwen2.5-7b-instruct",
    "format": "gguf",
    "displayName": "Qwen2.5 7B Instruct",
    "path": "lmstudio-community/Qwen2.5-7B-Instruct-GGUF/Qwen2.5-7B-Instruct-Q4_K_M.gguf",
    "sizeBytes": 4683073952,
    "paramsString": "7B",
    "architecture": "qwen2",
    "vision": false,
    "trainedForToolUse": true,
    "maxContextLength": 32768
  },
  {
    "type": "embedding",
    "modelKey": "text-embedding-nomic-embed-text-v1.5@q4_k_m",
    "format": "gguf",
    "displayName": "Nomic Embed Text v1.5",
    "path": "nomic-ai/nomic-embed-text-v1.5-GGUF/nomic-embed-text-v1.5.Q4_K_M.gguf",
    "sizeBytes": 84106624,
    "architecture": "nomic-bert",
    "maxContextLength": 2048
  }
]
```

<!-- Learn more about the `client.system` namespace in the [System API Reference](../api-reference/system-namespace). -->
