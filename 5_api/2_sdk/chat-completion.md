---
title: Chat Completion
description: Provide a chat context for the model to respond to
---

Once you have [downloaded and loaded](/docs/1_basics/index) a large language model,
you can use it to respond to input through the API. This article covers generating text
from a prompt or conversation like the in-app chat UI, but you can also
[request text completions](/docs/5_api/2_sdk/completion),
[use a vision-language model to chat about images](/docs/5_api/2_sdk/image-input), and
[get JSON structured output for programmatic use](/docs/5_api/2_sdk/structured-response).

To get a response to a simple prompt from a loaded LLM, use
the `respond` method on a the corresponding LLM handle.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()

        # You can either request the response token-by-token...
        prediction = llm.respond_stream("What is LM Studio?")
        for token in prediction:
            print(token, end="", flush=True)

        # ...or request the whole thing at once
        response = llm.respond("What is LM Studio?")
        print(response)

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()

            # You can either request the response token-by-token...
            prediction = llm.respond_stream("What is LM Studio?")
            for token in prediction:
                print(token, end="", flush=True)

            # ...or request the whole thing at once
            response = llm.respond("What is LM Studio?")
            print(response)

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

For more complicated conversations, use a `Chat` to handle message history.
A `Chat` can track system prompts, user messages, and assistant responses, as well as [files and images](/docs/5_api/2_sdk/image-input).

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()
        chat = lm.Chat("This is the system prompt!")
        chat.add_user_message("What is LM Studio?)

        response = llm.respond(chat)
        # TODO do you need .content?
        chat.add_assistant_response(response.content)

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()
            chat = lmstudio.Chat("This is the system prompt!")
            chat.add_user_message("What is LM Studio?)

            response = llm.respond(chat)
            # TODO do you need .content?
            chat.add_assistant_response(response.content)

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.model();

        // TODO how do you do Chats in typescript
        const prediction = llm.respond("What is LM Studio?");
        for await (const { content } of prediction) {
          process.stdout.write(content);
        }
```

## Advanced Usage

### Using JSON chat histories in Python

If you have an external chat history formatted in JSON like

```json
chat_history = {
  "messages": [
    { "role": "system", "content": "You are a helpful assistant." },
    { "role": "user", "content": "What is LM Studio?" }
  ]
}
```

you can load this directly into Python using `Chat.from_history(chat_history)`.

### Prediction metadata

TODO - copy from chat completion

### Prediction configuration

TODO - copy from chat completion
