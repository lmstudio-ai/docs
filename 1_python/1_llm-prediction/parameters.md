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
            temperature: 0.6,
            maxTokens: 50,
        })

    ".complete()":
      language: python
      code: |
        result = model.respond(chat, config={
            temperature: 0.6,
            maxTokens: 50,
            stop: ["\n\n"],
          })

```

See [`LLMPredictionConfigInput`](./../api-reference/llm-prediction-config-input) for all configurable fields.

Another useful inference-time configuration parameter is [`structured`](<(./structured-responses)>), which allows you to rigorously enforce the structure of the output using a JSON or Pydantic schema.

# Load Parameters

Set load-time parameters such as `contextLength`, `gpuOffload`, and more.

### Set Load Parameters with `.model()`

The `.model()` retrieves a handle to a model that has already been loaded, or loads a new one on demand (JIT loading).

**Note**: if the model is already loaded, the configuration will be **ignored**.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms
        model = lms.llm("qwen2.5-7b-instruct", config = {
            contextLength: 8192,
            gpuOffload: 0.5,
        })

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms
        with lms.Client() as client:
            model = client.llm.model(
                "qwen2.5-7b-instruct",
                config = {
                    contextLength: 8192,
                    gpuOffload: 0.5,
            })

```

See [`LLMLoadModelConfig`](./../api-reference/llm-load-model-config) for all configurable fields.

### Set Load Parameters with `.load_new_instance()`

The `.load_new_instance()` method creates a new model instance and loads it with the specified configuration.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms
        client = lms.get_default_client()
        model = client.llm.load_new_instance("qwen2.5-7b-instruct", config = {
            contextLength: 8192,
            gpuOffload: 0.5,
        })

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms
        with lms.Client() as client:
            model = client.llm.load_new_instance(
                "qwen2.5-7b-instruct",
                config = {
                    contextLength: 8192,
                    gpuOffload: 0.5,
            })

```

See [`LLMLoadModelConfig`](./../api-reference/llm-load-model-config) for all configurable fields.
