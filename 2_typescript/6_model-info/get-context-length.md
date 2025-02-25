---
title: Get Context Length
description: API to get the maximum context length of a model.
---

LLMs and embedding models, due to their fundamental architecture, have a property called `context length`, and more specifically a **maximum** context length.  Loosely speaking, this is how many tokens the models can "keep in memory" when generating text or embeddings. Exceeding this limit will result in the model behaving erratically.

## Use the `getContextLength()` function on the model object

It's useful to be able to check the context length of a model, especially as an extra check before providing potentially long input to the model.

```lms_code_snippet
  title: "index.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        const contextLength = await model.getContextLength();
```

The `model` in the above code snippet is an instance of a loaded model you get from the `llm.model` method. See [Manage Models in Memory](../manage-models/loading) for more information.

## Example: Check if the input will fit in the model's context length

To check whether a conversation is over the context limit for a model, use in conjunction with [countTokens()](../api-reference/count-tokens).

```lms_code_snippet
  title: "index.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        // TODO:
```