---
title: Chat Completion
description: Provide a chat context for the model to respond to
---

## Overview

Once you have [downloaded and loaded](/docs/basics/index) a large language model,
you can use it to respond to input through the API. This article covers generating text
from a prompt or conversation like the in-app chat UI, but you can also
[request text completions](/docs/api/sdk/completion),
[use a vision-language model to chat about images](/docs/api/sdk/image-input), and
[get JSON structured output for programmatic use](/docs/api/sdk/structured-response).

### Simple responses

To get a response to a simple prompt from a loaded LLM, pass the prompt to
the `respond` method on a the corresponding LLM handle. You can request
the response as a stream of tokens or all at once.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.model();

        const prediction = llm.respond("What is LM Studio?");
        for await (const { content } of prediction) {
          process.stdout.write(content);
        }
```

### Chats and conversations

For more complicated conversations, use a `Chat` to handle message history.
A `Chat` can track system prompts, user messages, and assistant responses, as well as [files and images](/docs/api/sdk/image-input).

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()
        chat = lm.Chat("This is the system prompt!")
        chat.add_user_message("What is LM Studio?")

        response = llm.respond(chat)
        chat.add_assistant_response(response.content)

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()
            chat = lmstudio.Chat("This is the system prompt!")
            chat.add_user_message("What is LM Studio?")

            response = llm.respond(chat)
            chat.add_assistant_response(response.content)

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient, Chat } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.model();
        const chat = Chat.createEmpty()
          .withAppended("system", "This is the system prompt!")
          .withAppended("user", "What is LM Studio?");

        const prediction = llm.respond(chat);
        for await (const { content } of prediction) {
          process.stdout.write(content);
        }
```

## Advanced Usage

### Using JSON chat histories

If you have an external chat history formatted in JSON like

```json
chat_history = {
  "messages": [
    { "role": "system", "content": "You are a helpful assistant." },
    { "role": "user", "content": "What is LM Studio?" }
  ]
}
```

you can load this directly into Python using `Chat.from_history(chat_history)`, or into TypeScript using `Chat.from(chat_history)`.

### Prediction metadata

Prediction responses are really returned as `PredictionResult` objects that contain additional dot-accessible metadata about the inference request.
This entails info about the model used, the configuration with which it was loaded, and the configuration for this particular prediction. It also provides
inference statistics like stop reason, time to first token, tokens per second, and number of generated tokens.

Please consult your specific SDK to see exact syntax.

### Progress callbacks

TODO: TS has onFirstToken callback which Python does not

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
in-app chat window sidebar. Please consult your specific SDK to see exact syntax.
