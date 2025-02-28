---
title: Get Context Length
description: API to get the maximum context length of a model.
---

LLMs and embedding models, due to their fundamental architecture, have a property called `context length`, and more specifically a **maximum** context length. Loosely speaking, this is how many tokens the models can "keep in memory" when generating text or embeddings. Exceeding this limit will result in the model behaving erratically.

## Use the `getContextLength()` Function on the Model Object

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

### Example: Check if the input will fit in the model's context window

You can determine if a given conversation fits into a model's context by doing the following:

1. Convert the conversation to a string using the prompt template.
2. Count the number of tokens in the string.
3. Compare the token count to the model's context length.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { Chat, type LLM, LMStudioClient } from "@lmstudio/sdk";

        async function doesChatFitInContext(model: LLM, chat: Chat) {
          // Convert the conversation to a string using the prompt template.
          const formatted = await model.applyPromptTemplate(chat);
          // Count the number of tokens in the string.
          const tokenCount = await model.countTokens(formatted);
          // Get the current loaded context length of the model
          const contextLength = await model.getContextLength();
          return tokenCount < contextLength;
        }

        const client = new LMStudioClient();
        const model = await client.llm.model();

        const chat = Chat.from([
          { role: "user", content: "What is the meaning of life." },
          { role: "assistant", content: "The meaning of life is..." },
          // ... More messages
        ]);

        console.info("Fits in context:", await doesChatFitInContext(model, chat));
```
