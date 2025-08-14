---
title: Get Load Config
description: Get the load configuration of the model
---

*Required Python SDK version*: **1.2.0**

LM Studio allows you to configure certain parameters when loading a model
[through the server UI](/docs/advanced/per-model) or [through the API](/docs/api/sdk/load-model).

You can retrieve the config with which a given model was loaded using the SDK.

In the below examples, the LLM reference can be replaced with an
embedding model reference without requiring any other changes.

```lms_protip
Context length is a special case that [has its own method](/docs/api/sdk/get-context-length).
```

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        model = lms.llm()

        print(model.get_load_config())

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms

        with lms.Client() as client:
            model = client.llm.model()

            print(model.get_load_config())

    "Python (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        import lmstudio as lms

        async with lms.Client() as client:
            model = await client.llm.model()

            print(await model.get_load_config())

```
