---
title: List Loaded Models
description: Query which models are currently loaded
---

## Overview

You can see which models are currently loaded in the LM Studio server using the SDK,
so that you can access them for inference or unload them.

### Usage

Call `listLoaded`/`list_loaded` on the desired model type (LLM/embedding).

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
