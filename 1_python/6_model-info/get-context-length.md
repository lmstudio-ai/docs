---
title: Get Context Length
description: API to get the maximum context length of a model.
---

LLMs and embedding models, due to their fundamental architecture, have a property called `context length`, and more specifically a **maximum** context length. Loosely speaking, this is how many tokens the models can "keep in memory" when generating text or embeddings. Exceeding this limit will result in the model behaving erratically.

## Use the `getContextLength()` function on the model object

It's useful to be able to check the context length of a model, especially as an extra check before providing potentially long input to the model.

```lms_code_snippet
  title: "example.py"
  variants:
    "Python (convenience API)":
      language: python
      code: |
        const contextLength = model.getContextLength()
```

The `model` in the above code snippet is an instance of a loaded model you get from the `llm.model` method. See [Manage Models in Memory](../manage-models/loading) for more information.

### Example: Check if the input will fit in the model's context window

You can determine if a given conversation fits into a model's context by doing the following:

1. Convert the conversation to a string using the prompt template.
2. Count the number of tokens in the string.
3. Compare the token count to the model's context length.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        # TODO
```
