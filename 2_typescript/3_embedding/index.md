---
title: Embedding
sidebar_title: Overview
description: Generate text embeddings from input text
---

## Load an Embedding Model

// todo embedding

## Create Embeddings

To embed a string, pass it to the `embed` method on the corresponding embedding model handle.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const emb = await client.embedding.model();

        const { embedding } = await emb.embed("Hello, world!");
```
