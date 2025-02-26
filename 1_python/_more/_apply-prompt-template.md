---
title: Apply Prompt Template
description: Apply a model's prompt template to a conversation
---

## Overview

LLMs (Large Language Models) operate on a text-in, text-out basis. Before processing conversations through these models, the input must be converted into a properly formatted string using a prompt template. If you need to inspect or work with this formatted string directly, the LM Studio SDK provides a streamlined way to apply a model's prompt template to your conversations.

```lms_info
You do not need to use this method when using `.respond`. It will automatically apply the prompt template for you.
```

## Usage with a Chat

You can apply a prompt template to a `Chat` by using the `applyPromptTemplate` method. This method takes a `Chat` object as input and returns a formatted string.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { Chat, LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.model(); // Use any loaded LLM

        const chat = Chat.createEmpty();
        chat.append("system", "You are a helpful assistant.");
        chat.append("user", "What is LM Studio?");
        const formatted = await llm.applyPromptTemplate(chat);
        console.info(formatted);
```

## Usage with an Array of Messages

The same method can also be used with any object that can be converted to a `Chat`, for example, an array of messages.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.model(); // Use any loaded LLM

        const formatted = await llm.applyPromptTemplate([
          { role: "system", content: "You are a helpful assistant." },
          { role: "user", content: "What is LM Studio?" },
        ]);
        console.info(formatted);
```
