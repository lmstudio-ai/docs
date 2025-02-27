---
title: Chat Completions
sidebar_title: Chat
description: APIs for a multi-turn chat conversations with an LLM
index: 2
---

Use `llm.respond(...)` to generate completions for a chat conversation.

## Quick Example: Generate a Chat Response

The following snippet shows how to obtain the AI's response to a quick chat prompt.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lm
        model = lm.llm()
        print(model.respond("What is the meaning of life?"))

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio
        with lmstudio.Client() as client:
            model = client.llm.model()
            print(model.respond("What is the meaning of life?"))
```

## Streaming a Chat Response

The following snippet shows how to stream the AI's response to a chat prompt,
displaying text fragments as they are received (rather than waiting for the
entire response to be generated before displaying anything).

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lm
        model = lm.llm()

        for fragment in model.respond_stream("What is the meaning of life?"):
            print(fragment.content, end="", flush=True)
        print() # Advance to a new line at the end of the response

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio
        with lmstudio.Client() as client:
            model = client.llm.model()

            for fragment in model.respond_stream("What is the meaning of life?"):
                print(fragment.content, end="", flush=True)
            print() # Advance to a new line at the end of the response

```

## Obtain a Model

First, you need to get a model handle.
This can be done using the top-level `llm` convenience API,
or the `model` method in the `llm` namespace when using the scoped resource API.
For example, here is how to use Qwen2.5 7B Instruct.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lm
        model = lm.llm("qwen2.5-7b-instruct")

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio
        with lmstudio.Client() as client:
            model = client.llm.model("qwen2.5-7b-instruct")

```

There are other ways to get a model handle. See [Managing Models in Memory](./../manage-models/loading) for more info.

## Manage Chat Context

The input to the model is referred to as the "context".
Conceptually, the model receives a multi-turn conversation as input,
and it is asked to predict the assistant's response in that conversation.

```lms_code_snippet
  variants:
    "Using an array of messages":
      language: python
      code: |
        import lmstudio as lm

        # Create a chat object from an array of messages.
        chat = lm.Chat()
        chat.add_entries([
          { role: "system", content: "You are a resident AI philosopher." },
          { role: "user", content: "What is the meaning of life?" },
        ])
        # ... continued in next example

    "Constructing a Chat object":
      language: python
      code: |
        import lmstudio as lm

        # Create a chat with an initial system prompt.
        const chat = lm.Chat("You are a resident AI philosopher.")

        # Build the chat context by adding messages of relevant types.
        chat.add_user_message("What is the meaning of life?")
        # ... continued in next example

```

See [Working with Chats](./working-with-chats) for more information on managing chat context,
and [`Chat`](./../api-reference/chat) for API reference for the `Chat` class.

## Generate a response

You can ask the LLM to predict the next response in the chat context using the `respond()` method.

```lms_code_snippet
  variants:
    Streaming:
      language: python
      code: |
        # The `chat` object is created in the previous step.
        prediction_stream = model.respond_stream(chat)

        for fragment in prediction_stream:
            print(fragment.content, end="", flush=True)
        print() # Advance to a new line at the end of the response

    "Non-streaming":
      language: python
      code: |
        # The `chat` object is created in the previous step.
        result = model.respond(chat)

        print(result)
```

## Customize Inferencing Parameters

You can pass in inferencing parameters via the `config` keyword parameter on `.respond()`.

```lms_code_snippet
  variants:
    Streaming:
      language: python
      code: |
        prediction_stream = model.respond_stream(chat, config={
            temperature: 0.6,
            maxTokens: 50,
        })

    "Non-streaming":
      language: python
      code: |
        result = model.respond(chat, config={
            temperature: 0.6,
            maxTokens: 50,
        })
```

See [Configuring the Model](./parameters) for more information on what can be configured.

## Print prediction stats

You can also print prediction metadata, such as the model used for generation, number of generated
tokens, time to first token, and stop reason.

```lms_code_snippet
  variants:
    Streaming:
      language: python
      code: |
        # After iterating through the prediction fragments,
        # the overall prediction result may be obtained from the stream
        result = prediction_stream.result()

        print("Model used:", result.model_info.display_name)
        print("Predicted tokens:", result.stats.predicted_tokens_count)
        print("Time to first token (seconds):", result.stats.time_to_first_token_sec)
        print("Stop reason:", result.stats.stop_reason)
    "Non-streaming":
      language: python
      code: |
        # `result` is the response from the model.
        print("Model used:", result.model_info.display_name)
        print("Predicted tokens:", result.stats.predicted_tokens_count)
        print("Time to first token (seconds):", result.stats.time_to_first_token_sec)
        print("Stop reason:", result.stats.stop_reason)
```

## Example: Multi-turn Chat

```lms_code_snippet
  title: "chatbot.py"
  variants:
    Python:
      language: python
      code: |
        import readline # Enables input line editing

        import lmstudio as lm

        model = lm.llm()
        chat = lm.Chat("You are a task focused AI assistant")

        while True:
            try:
                user_input = input("You (leave blank to exit): ")
            except EOFError:
                print()
                break
            if not user_input:
                break
            chat.add_user_message(user_input)
            prediction_stream = model.respond_stream(
                chat,
                on_message=chat.append,
            )
            print("Bot: ", end="", flush=True)
            for fragment in prediction_stream:
                print(fragment.content, end="", flush=True)
            print()

```

<!-- ### Progress callbacks

TODO: Cover available callbacks (Python SDK has all of these now)

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

    "Python (convenience API)":
      language: python
      code: |
        import { LMStudioClient } from "@lmstudio/sdk"

        const client = new LMStudioClient()
        const llm = client.llm.model()

        const prediction = llm.respond(
          "What is LM Studio?",
          {onPromptProcessingProgress: (progress) => process.stdout.write(`${progress*100}% processed`)})
```

### Prediction configuration

You can also specify the same prediction configuration options as you could in the
in-app chat window sidebar. Please consult your specific SDK to see exact syntax. -->
