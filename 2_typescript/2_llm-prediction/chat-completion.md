---
title: Chat Completions
sidebar_title: Chat
description: APIs for a multi-turn chat conversations with an LLM
index: 2
---

Use `llm.respond(...)` to generate completions for a chat conversation.

## Quick Example: Generate a Chat Response

The following snippet shows how to stream the AI's response to quick chat prompt.

```lms_code_snippet
  title: "index.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";
        const client = new LMStudioClient();

        const model = await client.llm.model();

        for await (const fragment of model.respond("What is the meaning of life?")) {
          process.stdout.write(fragment.content);
        }
```

## Obtain a Model

First, you need to get a model handle. This can be done using the `model` method in the `llm` namespace. For example, here is how to use Qwen2.5 7B Instruct.

```lms_code_snippet
  title: "index.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";
        const client = new LMStudioClient();

        const model = await client.llm.model("qwen2.5-7b-instruct");
```

There are other ways to get a model handle. See [Managing Models in Memory](./../manage-models/loading) for more info.

## Manage Chat Context

The input to the model is referred to as the "context". Conceptually, the model receives a multi-turn conversation as input, and it is asked to predict the assistant's response in that conversation.

```lms_code_snippet
  variants:
    "Using an array of messages":
      language: typescript
      code: |
        import { Chat } from "@lmstudio/sdk";

        // Create a chat object from an array of messages.
        const chat = Chat.from([
          { role: "system", content: "You are a resident AI philosopher." },
          { role: "user", content: "What is the meaning of life?" },
        ]);
    "Constructing a Chat object":
      language: typescript
      code: |
        import { Chat } from "@lmstudio/sdk";

        // Create an empty chat object.
        const chat = Chat.empty();

        // Build the chat context by appending messages.
        chat.append("system", "You are a resident AI philosopher.");
        chat.append("user", "What is the meaning of life?");
```

See [Working with Chats](./working-with-chats) for more information on managing chat context.

<!-- , and [`Chat`](./../api-reference/chat) for API reference for the `Chat` class. -->

## Generate a response

You can ask the LLM to predict the next response in the chat context using the `respond()` method.

```lms_code_snippet
  variants:
    Streaming:
      language: typescript
      code: |
        // The `chat` object is created in the previous step.
        const prediction = model.respond(chat);

        for await (const { content } of prediction) {
          process.stdout.write(content);
        }

        console.info(); // Write a new line to prevent text from being overwritten by your shell.

    "Non-streaming":
      language: typescript
      code: |
        // The `chat` object is created in the previous step.
        const result = await model.respond(chat);

        console.info(result.content);
```

## Customize Inferencing Parameters

You can pass in inferencing parameters as the second parameter to `.respond()`.

```lms_code_snippet
  variants:
    Streaming:
      language: typescript
      code: |
        const prediction = model.respond(chat, {
          temperature: 0.6,
          maxTokens: 50,
        });

    "Non-streaming":
      language: typescript
      code: |
        const result = await model.respond(chat, {
          temperature: 0.6,
          maxTokens: 50,
        });
```

See [Configuring the Model](./parameters) for more information on what can be configured.

## Print prediction stats

You can also print prediction metadata, such as the model used for generation, number of generated
tokens, time to first token, and stop reason.

```lms_code_snippet
  variants:
    Streaming:
      language: typescript
      code: |
        // If you have already iterated through the prediction fragments,
        // doing this will not result in extra waiting.
        const result = await prediction.result();

        console.info("Model used:", result.modelInfo.displayName);
        console.info("Predicted tokens:", result.stats.predictedTokensCount);
        console.info("Time to first token (seconds):", result.stats.timeToFirstTokenSec);
        console.info("Stop reason:", result.stats.stopReason);
    "Non-streaming":
      language: typescript
      code: |
        // `result` is the response from the model.
        console.info("Model used:", result.modelInfo.displayName);
        console.info("Predicted tokens:", result.stats.predictedTokensCount);
        console.info("Time to first token (seconds):", result.stats.timeToFirstTokenSec);
        console.info("Stop reason:", result.stats.stopReason);
```

## Example: Multi-turn Chat

<!-- TODO: Probably needs polish here: -->

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { Chat, LMStudioClient } from "@lmstudio/sdk";
        import { createInterface } from "readline/promises";

        const rl = createInterface({ input: process.stdin, output: process.stdout });
        const client = new LMStudioClient();
        const model = await client.llm.model();
        const chat = Chat.empty();

        while (true) {
          const input = await rl.question("You: ");
          // Append the user input to the chat
          chat.append("user", input);

          const prediction = model.respond(chat, {
            // When the model finish the entire message, push it to the chat
            onMessage: (message) => chat.append(message),
          });
          process.stdout.write("Bot: ");
          for await (const { content } of prediction) {
            process.stdout.write(content);
          }
          process.stdout.write("\n");
        }
```

<!-- ### Progress callbacks

TODO: Cover onFirstToken callback (Python SDK has this now)

Long prompts will often take a long time to first token, i.e. it takes the model a long time to process your prompt.
If you want to get updates on the progress of this process, you can provide a float callback to `respond`
that receives a float from 0.0-1.0 representing prompt processing progress.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()

        response = llm.respond(
            "What is LM Studio?",
            on_progress: lambda progress: print(f"{progress*100}% complete")
        )

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()

            response = llm.respond(
                "What is LM Studio?",
                on_progress: lambda progress: print(f"{progress*100}% processed")
            )

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.model();

        const prediction = llm.respond(
          "What is LM Studio?",
          {onPromptProcessingProgress: (progress) => process.stdout.write(`${progress*100}% processed`)});
```

### Prediction configuration

You can also specify the same prediction configuration options as you could in the
in-app chat window sidebar. Please consult your specific SDK to see exact syntax. -->
