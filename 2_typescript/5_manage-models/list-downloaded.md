---
title: List Local Models
description: Query which models are currently downloaded
---

You can see which models have been downloaded to the machine running LM Studio
using the SDK, so that you can [load them](/docs/api/sdk/load-and-access-models) for inference.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();

        const downloaded = client.system.listDownloadedModels();
        const llmOnly = downloaded.filter((model) => model.type === "llm");
        const embeddingOnly = downloaded.filter((model) => model.type === "embedding");
```

## CLI usage

TODO `lms ls`
