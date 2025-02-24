---
title: Tokenization
sidebar_title: Overview
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
        const llm = await client.llm.model();

        const tokens = await llm.tokenize("Hello, world!");

        // TODO: iterable of strings
```

## Count tokens

### Example: count context

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
