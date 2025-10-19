---
title: "Manage Models in Memory"
sidebar_title: Load and Access Models
description: APIs to load, access, and unload models from memory
---

AI models are huge. It can take a while to load them into memory. LM Studio's SDK allows you to precisely control this process.

**Model namespaces:**

- LLMs are accessed through the `client.llm` namespace
- Embedding models are accessed through the `client.embedding` namespace
- `lmstudio.llm` is equivalent to `client.llm.model` on the default client
- `lmstudio.embedding_model` is equivalent to `client.embedding.model` on the default client

**Most commonly:**

- Use `.model()` to get any currently loaded model
- Use `.model("model-key")` to use a specific model

**Advanced (manual model management):**

- Use `.load_new_instance("model-key")` to load a new instance of a model
- Use `.unload("model-key")` or `model_handle.unload()` to unload a model from memory

## Get the Current Model with `.model()`

If you already have a model loaded in LM Studio (either via the GUI or `lms load`),
you can use it by calling `.model()` without any arguments.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        model = lms.llm()

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms

        with lms.Client() as client:
            model = client.llm.model()

    "Python (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        import lmstudio as lms

        async with lms.AsyncClient() as client:
            model = await client.llm.model()

```

## Get a Specific Model with `.model("model-key")`

If you want to use a specific model, you can provide the model key as an argument to `.model()`.

#### Get if Loaded, or Load if not

Calling `.model("model-key")` will load the model if it's not already loaded, or return the existing instance if it is.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        model = lms.llm("qwen/qwen3-4b-2507")

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms

        with lms.Client() as client:
            model = client.llm.model("qwen/qwen3-4b-2507")

    "Python (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        import lmstudio as lms

        async with lms.AsyncClient() as client:
            model = await client.llm.model("qwen/qwen3-4b-2507")

```

<!--
Learn more about the `.model()` method and the parameters it accepts in the [API Reference](../api-reference/model).
-->

## Load a New Instance of a Model with `.load_new_instance()`

Use `load_new_instance()` to load a new instance of a model, even if one already exists.
This allows you to have multiple instances of the same or different models loaded at the same time.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        client = lms.get_default_client()
        model = client.llm.load_new_instance("qwen/qwen3-4b-2507")
        another_model = client.llm.load_new_instance("qwen/qwen3-4b-2507", "my-second-model")

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms

        with lms.Client() as client:
            model = client.llm.load_new_instance("qwen/qwen3-4b-2507")
            another_model = client.llm.load_new_instance("qwen/qwen3-4b-2507", "my-second-model")

    "Python (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        import lmstudio as lms

        async with lms.AsyncClient() as client:
            model = await client.llm.load_new_instance("qwen/qwen3-4b-2507")
            another_model = await client.llm.load_new_instance("qwen/qwen3-4b-2507", "my-second-model")

```

<!--
Learn more about the `.load_new_instance()` method and the parameters it accepts in the [API Reference](../api-reference/load_new_instance).
-->

### Note about Instance Identifiers

If you provide an instance identifier that already exists, the server will throw an error.
So if you don't really care, it's safer to not provide an identifier, in which case
the server will generate one for you. You can always check in the server tab in LM Studio, too!

## Unload a Model from Memory with `.unload()`

Once you no longer need a model, you can unload it by simply calling `unload()` on its handle.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        model = lms.llm()
        model.unload()

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms

        with lms.Client() as client:
            model = client.llm.model()
            model.unload()

    "Python (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        import lmstudio as lms

        async with lms.AsyncClient() as client:
            model = await client.llm.model()
            await model.unload()

```

## Set Custom Load Config Parameters

You can also specify the same load-time configuration options when loading a model, such as Context Length and GPU offload.

See [load-time configuration](../llm-prediction/parameters) for more.

## Set an Auto Unload Timer (TTL)

You can specify a _time to live_ for a model you load, which is the idle time (in seconds)
after the last request until the model unloads. See [Idle TTL](/docs/app/api/ttl-and-auto-evict) for more on this.

```lms_protip
If you specify a TTL to `model()`, it will only apply if `model()` loads
a new instance, and will _not_ retroactively change the TTL of an existing instance.
```

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        model = lms.llm("qwen/qwen3-4b-2507", ttl=3600)

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms

        with lms.Client() as client:
            model = client.llm.model("qwen/qwen3-4b-2507", ttl=3600)

    "Python (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        import lmstudio as lms

        async with lms.AsyncClient() as client:
            model = await client.llm.model("qwen/qwen3-4b-2507", ttl=3600)

```

<!--
(TODO?: Cover the JIT implications of setting a TTL, and the default TTL variations)
-->
