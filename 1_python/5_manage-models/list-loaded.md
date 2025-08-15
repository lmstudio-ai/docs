---
title: List Loaded Models
description: Query which models are currently loaded
---

You can iterate through models loaded into memory using the functions and methods shown below.

The results are full SDK model handles, allowing access to all model functionality. 


## List Models Currently Loaded in Memory

This will give you results equivalent to using [`lms ps`](../../cli/ps) in the CLI.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        all_loaded_models = lms.list_loaded_models()
        llm_only = lms.list_loaded_models("llm")
        embedding_only = lms.list_loaded_models("embedding")

        print(all_loaded_models)

    Python (scoped resource API):
      language: python
      code: |
        import lms

        with lms.Client() as client:
            all_loaded_models = client.list_loaded_models()
            llm_only = client.llm.list_loaded()
            embedding_only = client.embedding.list_loaded()

            print(all_loaded_models)

    "Python (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        import lmstudio as lms

        async with lms.AsyncClient() as client:
            all_loaded_models = await client.list_loaded_models()
            llm_only = await client.llm.list_loaded()
            embedding_only = await client.embedding.list_loaded()

            print(all_loaded_models)

```
