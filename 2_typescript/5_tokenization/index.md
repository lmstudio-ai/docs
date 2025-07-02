---
title: Tokenization
sidebar_title: Tokenizing text
description: Tokenize text using a model's tokenizer
---

Models use a tokenizer to internally convert text into "tokens" they can deal with more easily. LM Studio exposes this tokenizer for utility.

## Tokenize

You can tokenize a string with a loaded LLM or embedding model using the SDK. In the below examples, `llm` can be replaced with an embedding model `emb`.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const model = await client.llm.model();

        const tokens = await model.tokenize("Hello, world!");

        console.info(tokens); // Array of token IDs.
```

## Count tokens

If you only care about the number of tokens, you can use the `.countTokens` method instead.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        const tokenCount = await model.countTokens("Hello, world!");
        console.info("Token count:", tokenCount);
```

### Example: Count Context

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

<!-- ### Context length comparisons

The below examples check whether a conversation is over a LLM's context length
(replace `llm` with `emb` to check for an embedding model).

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient, Chat } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.model();

        // To check for a string, simply tokenize
        var tokens = await llm.tokenize("Hello, world!");

        // To check for a Chat, apply the prompt template first
        const chat = Chat.createEmpty().withAppended("user", "Hello, world!");
        const templatedChat = await llm.applyPromptTemplate(chat);
        tokens = await llm.tokenize(templatedChat);

        // If the prompt's length in tokens is less than the context length, you're good!
        const contextLength = await llm.getContextLength()
        const isOkay = (tokens.length < contextLength)
``` -->
