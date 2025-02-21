---
title: Get Context Length
description: Get the context length of the model
---

## Overview

Because a model cannot respond to prompts longer than its context length, it can be useful
to know what the context length of your model is.

### Usage

You can obtain the context length of a loaded LLM or embedding model using the SDK. In the below examples, `llm` can be replaced with an embedding model `emb`.

```lms_protip
To check whether a conversation is over the context limit for a model,
use this in conjunction with [tokenization](/docs/api/sdk/tokenization)
(see that page).
```

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.model();
        const contextLength = await llm.getContextLength();
```
