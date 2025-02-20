---
title: Chat Completion
description: Provide a chat context for the model to respond to
---

## Overview

Once you have [downloaded and loaded](/docs/basics/index) a large language model,
you can use it to respond to input through the API. This article covers generating text
from a prompt or conversation like the in-app chat UI, but you can also
[request text completions](/docs/sdk/python/completion), and
[get structured output for programmatic use](/docs/sdk/python/structured-response).


[//] # (TODO: Add file/vision processing references once those APIs are deemed stable)

### Simple responses

To get a response to a simple prompt from a loaded LLM, pass the prompt to
the `respond()` or `respond_stream()` method on the corresponding LLM handle.
You can request the response as a stream of prediction fragments or all at once.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()

        # You can process the response content incrementally...
        prediction_stream = llm.respond_stream("What is LM Studio?")
        for content_fragment in prediction_stream:
            print(content_fragment, end="", flush=True)
        # ...and then access the complete result at the end.
        response = prediction_stream.result()

        # Alternatively, the SDK can internally handle both of those steps
        response = llm.respond("What is LM Studio?")
        print(response)

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()

            # You can process the response content incrementally...
            prediction_stream = llm.respond_stream("What is LM Studio?")
            for content_fragment in prediction_stream:
                print(content_fragment, end="", flush=True)
            # ...and then access the complete result at the end.
            response = prediction_stream.result()

            # Alternatively, the SDK can internally handle both of those steps
            response = llm.respond("What is LM Studio?")
            print(response)
```

#### Content fragments

The content fragments emitted by the iteration API are text values that will
form part of the final result. While each fragment will often correspond
to a single predicted token, this is not guaranteed (a single fragment may
consist of multiple tokens, and in some cases, may even contain partial tokens)

Additional details on the progress of a prediction may be obtained via the
callback interfaces described below.

#### Prediction results

Prediction results offer the following public attributes:

* `content`: the text content of the assistant response
* `parsed`: for structured responses, this is a string-keyed dict matching
  the requested response structure. For unstructured responses, it contains
  the exact same text as the `content` field
* `structured`: a boolean flag indicating this is a structured result
* `stats`: information regarding the prediction process
* `model_info`: information regarding the LLM making the prediction

Printing an unstructured result is equivalent to printing its `content` attribute.
Printing a structured result gives a pretty-printed JSON rendering of its `parsed`
attribute rather than printing the raw `content` attribute.

### Chats and conversations

For more complicated conversations, use a `Chat` to handle message history.
A `Chat` can track system prompts, user messages, and assistant responses.

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
        chat.add_assistant_response(response)

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()
            chat = lmstudio.Chat("This is the system prompt!")
            chat.add_user_message("What is LM Studio?")

            response = llm.respond(chat)
            chat.add_assistant_response(response)
```

When adding assistant responses to a chat instance, adding a
prediction result directly is equivalent to adding its `content`
attribute (for both structured and unstructured predictions).

## Advanced Usage

### Structured responses

Requesting [structured output for programmatic use](/docs/sdk/python/structured-response)
is covered on the linked page.

### Using JSON chat histories

When populating an initial chat history state, it may be more convenient
to provide it as a JSON-compatible data structure like the following:

```json
chat_history = {
  "messages": [
    { "role": "system", "content": "You are a helpful assistant." },
    { "role": "user", "content": "What is LM Studio?" }
  ]
}
```

Chat histories in this format may be loaded directly into a new `Chat` instance
using the `from_history` alternative constructor: `Chat.from_history(chat_history)`.

### Prediction metadata

As noted above, prediction results provide additional details on the operation of
the prediction process, and details of the model used to make the prediction.

[//] # (TODO: Note the config reporting once it uses a client-friendly format)

This entails info about the model used, the configuration with which it was loaded, and the configuration for this particular prediction. It also provides
inference statistics like stop reason, time to first token, tokens per second, and number of generated tokens.

### Progress callbacks

[//] # (TODO: Add fragment processing and complete message callbacks to Python SDK)

When given a complex prompt, models may take a long time to emit the first predicted token.
This means that even the iterator API may encounter a long pause when waiting for the first
prediction content fragment.

In order to request status updates during this stage of the process, `respond()` and `respond_stream()`
both accept optional `on_progress` callback parameters. These callback methods accept a single
`float` callback value which progresses from `0.0` through to `1.0` as the LM Studio instance
provides updates on the prompt processing progress.

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
```

### Prediction configuration

The same prediction configuration options that may be specified via the Lm Studio
in-app chat window sidebar may be specified via the SDK using the `config`
keyword-only parameter on the prediction request methods.

If using a type hinting aware Python editor, config dictionary keys are type
hinted appropriately, so the IDE will pick up spelling and data type errors.
Alternatively, the `lmstudio.LlmPredictionConfig` type may be used explicitly
when defining the configuration (although this approach is typically more
verbose than a using dictionary based configuration).
