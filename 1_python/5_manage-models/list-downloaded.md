---
title: List Downloaded Models
description: APIs to list the available models in a given local environment
---

You can iterate through locally available models using the downloaded model listing methods.

The listing results offer `.model()` and `.load_new_instance()` methods, which allow the
downloaded model reference to be converted in the full SDK handle for a loaded model.

## Available Models on the LM Studio Server

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        downloaded = lms.list_downloaded_models()
        llm_only = lms.list_downloaded_models("llm")
        embedding_only = lms.list_downloaded_models("embedding")

        for model in downloaded:
            print(model)

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms

        with lms.Client() as client:
            downloaded = client.list_downloaded_models()
            llm_only = client.llm.list_downloaded()
            embedding_only = client.embedding.list_downloaded()

        for model in downloaded:
            print(model)

    "Python (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        import lmstudio as lms

        async with lms.AsyncClient() as client:
            downloaded = await client.list_downloaded_models()
            llm_only = await client.llm.list_downloaded()
            embedding_only = await client.embedding.list_downloaded()

        for model in downloaded:
            print(model)

```
This will give you results equivalent to using [`lms ls`](../../cli/ls) in the CLI.


### Example output:

```python
DownloadedLlm(model_key='qwen2.5-7b-instruct-1m', display_name='Qwen2.5 7B Instruct 1M', architecture='qwen2', vision=False)
DownloadedEmbeddingModel(model_key='text-embedding-nomic-embed-text-v1.5', display_name='Nomic Embed Text v1.5', architecture='nomic-bert')
```
