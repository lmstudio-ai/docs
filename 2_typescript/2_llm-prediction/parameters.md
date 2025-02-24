---
title: Configuring the Model
description: TODO
---

TODO: info about load vs inferencing

## Load Parameters

### `.model`

TODO: Info about this only works if the model is newly loaded.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        const model = await client.llm.model("qwen2.5-7b-instruct", {
          config: {
            contextLength: 8192,
            keepModelInMemory: true,
          },
        });
```

See [`LLMLoadModelConfig`](./../api-reference/llm-load-model-config) for all configurable fields.

### `.load` (Advanced)

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        const model = await client.llm.load("qwen2.5-7b-instruct", {
          config: {
            contextLength: 8192,
            keepModelInMemory: true,
          },
        });
```

See [`LLMLoadModelConfig`](./../api-reference/llm-load-model-config) for all configurable fields.

## Inferencing Parameters

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        const prediction = model.respond(chat, {
          temperature: 0.6,
          maxTokens: 50,
        });
```

See [`LLMPredictionConfigInput`](./../api-reference/llm-prediction-config-input) for all configurable fields.
