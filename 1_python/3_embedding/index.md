---
title: Embedding
sidebar_title: Generating embedding vectors
description: Generate text embeddings from input text
---

Generate embeddings for input text. Embeddings are vector representations of text that capture semantic meaning. Embeddings are a building block for RAG (Retrieval-Augmented Generation) and other similarity-based tasks.

### Prerequisite: Get an Embedding Model

If you don't yet have an embedding model, you can download a model like `nomic-ai/nomic-embed-text-v1.5` using the following command:

```bash
lms get nomic-ai/nomic-embed-text-v1.5
```

## Create Embeddings

To convert a string to a vector representation, pass it to the `embed` method on the corresponding embedding model handle.

```lms_code_snippet
  title: "example.py"
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        model = lms.embedding_model("nomic-embed-text-v1.5")

        embedding = model.embed("Hello, world!")

```
