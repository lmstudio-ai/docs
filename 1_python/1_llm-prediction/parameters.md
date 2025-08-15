---
title: Configuring the Model
sidebar_title: Configuration Parameters
description: APIs for setting inference-time and load-time parameters for your model
---

You can customize both inference-time and load-time parameters for your model. Inference parameters can be set on a per-request basis, while load parameters are set when loading the model.

# Inference Parameters

Set inference-time parameters such as `temperature`, `maxTokens`, `topP` and more.

```lms_code_snippet
  variants:
    ".respond()":
      language: python
      code: |
        result = model.respond(chat, config={
            "temperature": 0.6,
            "maxTokens": 50,
        })

    ".complete()":
      language: python
      code: |
        result = model.complete(chat, config={
            "temperature": 0.6,
            "maxTokens": 50,
            "stopStrings": ["\n\n"],
          })

```

See [`LLMPredictionConfigInput`](./../../typescript/api-reference/llm-prediction-config-input) in the
Typescript SDK documentation for all configurable fields.

Note that while `structured` can be set to a JSON schema definition as an inference-time configuration parameter
(Zod schemas are not supported in the Python SDK), the preferred approach is to instead set the
[dedicated `response_format` parameter](<(./structured-responses)>), which allows you to more rigorously
enforce the structure of the output using a JSON or class based schema definition.

# Load Parameters

Set load-time parameters such as the context length, GPU offload ratio, and more.

### Set Load Parameters with `.model()`

The `.model()` retrieves a handle to a model that has already been loaded, or loads a new one on demand (JIT loading).

**Note**: if the model is already loaded, the given configuration will be **ignored**.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        model = lms.llm("qwen2.5-7b-instruct", config={
            "contextLength": 8192,
            "gpu": {
              "ratio": 0.5,
            }
        })

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms

        with lms.Client() as client:
            model = client.llm.model(
                "qwen2.5-7b-instruct",
                config={
                    "contextLength": 8192,
                    "gpu": {
                      "ratio": 0.5,
                    }
                }
            )

    "Python (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        import lmstudio as lms

        async with lms.AsyncClient() as client:
            model = await client.llm.model(
                "qwen2.5-7b-instruct",
                config={
                    "contextLength": 8192,
                    "gpu": {
                      "ratio": 0.5,
                    }
                }
            )

```

See [`LLMLoadModelConfig`](./../../typescript/api-reference/llm-load-model-config) in the
Typescript SDK documentation for all configurable fields.

### Set Load Parameters with `.load_new_instance()`

The `.load_new_instance()` method creates a new model instance and loads it with the specified configuration.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        client = lms.get_default_client()
        model = client.llm.load_new_instance("qwen2.5-7b-instruct", config={
            "contextLength": 8192,
            "gpu": {
              "ratio": 0.5,
            }
        })

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms

        with lms.Client() as client:
            model = client.llm.load_new_instance(
                "qwen2.5-7b-instruct",
                config={
                    "contextLength": 8192,
                    "gpu": {
                      "ratio": 0.5,
                    }
                }
            )

    "Python (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        import lmstudio as lms

        async with lms.AsyncClient() as client:
            model = await client.llm.load_new_instance(
                "qwen2.5-7b-instruct",
                config={
                    "contextLength": 8192,
                    "gpu": {
                      "ratio": 0.5,
                    }
                }
            )

```

See [`LLMLoadModelConfig`](./../../typescript/api-reference/llm-load-model-config) in the
Typescript SDK documentation for all configurable fields.
