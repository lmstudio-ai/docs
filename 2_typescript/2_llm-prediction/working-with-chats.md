---
title: Working with Chats
description: APIs for representing a chat conversation with an LLM
index: 3
---

SDK methods such as `model.respond()`, `model.applyPromptTemplate()`, or `model.act()`
takes in a chat parameter as an input. There are a few ways to represent a chat in the SDK.

## Option 1: Array of Messages

You can use an array of messages to represent a chat. Here is an example with the `.respond()` method.

```lms_code_snippet
variants:
  "Text-only":
    language: typescript
    code: |
      const prediction = model.respond([
        { role: "system", content: "You are a resident AI philosopher." },
        { role: "user", content: "What is the meaning of life?" },
      ]);
  With Images:
    language: typescript
    code: |
      const image = await client.files.prepareImage("/path/to/image.jpg");

      const prediction = model.respond([
        { role: "system", content: "You are a state-of-art object recognition system." },
        { role: "user", content: "What is this object?", images: [image] },
      ]);
```

## Option 2: Input a Single String

If your chat only has one single user message, you can use a single string to represent the chat. Here is an example with the `.respond` method.

```lms_code_snippet
variants:
  TypeScript:
    language: typescript
    code: |
      const prediction = model.respond("What is the meaning of life?");
```

## Option 3: Using the `Chat` Helper Class

For more complex tasks, it is recommended to use the `Chat` helper classes. It provides various commonly used methods to manage the chat. Here is an example with the `Chat` class.

```lms_code_snippet
variants:
  "Text-only":
    language: typescript
    code: |
      const chat = Chat.empty();
      chat.append("system", "You are a resident AI philosopher.");
      chat.append("user", "What is the meaning of life?");

      const prediction = model.respond(chat);
  With Images:
    language: typescript
    code: |
      const image = await client.files.prepareImage("/path/to/image.jpg");

      const chat = Chat.empty();
      chat.append("system", "You are a state-of-art object recognition system.");
      chat.append("user", "What is this object?", { images: [image] });

      const prediction = model.respond(chat);
```

You can also quickly construct a `Chat` object using the `Chat.from` method.

```lms_code_snippet
variants:
  "Array of messages":
    language: typescript
    code: |
      const chat = Chat.from([
        { role: "system", content: "You are a resident AI philosopher." },
        { role: "user", content: "What is the meaning of life?" },
      ]);
  "Single string":
    language: typescript
    code: |
      // This constructs a chat with a single user message
      const chat = Chat.from("What is the meaning of life?");
```
