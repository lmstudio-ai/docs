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
      language: typescript
      code: |
        const prediction = model.respond(chat, {
          temperature: 0.6,
          maxTokens: 50,
        });
    ".complete()":
        language: typescript
        code: |
          const prediction = model.complete(prompt, {
            temperature: 0.6,
            maxTokens: 50,
            stop: ["\n\n"],
          });
```

See [`LLMPredictionConfigInput`](./../api-reference/llm-prediction-config-input) for all configurable fields.

Another useful inference-time configuration parameter is [`structured`](<(./structured-responses)>), which allows you to rigorously enforce the structure of the output using a JSON or zod schema.

# Load Parameters

Set load-time parameters such as the context length, GPU offload ratio, and more.

### Set Load Parameters with `.model()`

The `.model()` retrieves a handle to a model that has already been loaded, or loads a new one on demand (JIT loading).

**Note**: if the model is already loaded, the configuration will be **ignored**.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        const model = await client.llm.model("qwen2.5-7b-instruct", {
          config: {
            contextLength: 8192,
            gpu: {
              ratio: 0.5,
            },
          },
        });
```

See [`LLMLoadModelConfig`](./../api-reference/llm-load-model-config) for all configurable fields.

### Set Load Parameters with `.load()`

The `.load()` method creates a new model instance and loads it with the specified configuration.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        const model = await client.llm.load("qwen2.5-7b-instruct", {
          config: {
            contextLength: 8192,
            gpu: {
              ratio: 0.5,
            },
          },
        });
```

See [`LLMLoadModelConfig`](./../api-reference/llm-load-model-config) for all configurable fields.
