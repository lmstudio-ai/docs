---
title: Embedding
description: Generate text embeddings from input text
---

## Overview

Once you have [downloaded and loaded](/docs/basics/index) an embedding model,
you can use it to create semantic representations of text for applications like
[RAG](/docs/basics/rag).

### Usage

To embed a string or list of strings, pass it to the `embed` method on the corresponding embedding model handle.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const emb = await client.embedding.model();

        const { embedding } = await emb.embed("Hello, world!");
        // TODO: iterable of strings
```
