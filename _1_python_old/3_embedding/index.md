---
title: Overview
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
    Python:
      language: python
      code: |
        import lmstudio as lm

        emb = lm.embedding_model()

        embedding = emb.embed("Hello, world!")

        # You can also pass an iterable of strings
        embeddings = emb.embed(["Hello, world!", "Goodbye, world!"])

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:

            emb = client.embedding.model()

            embedding = emb.embed("Hello, world!")

            # You can also pass an iterable of strings
            embeddings = emb.embed(["Hello, world!", "Goodbye, world!"])
```
