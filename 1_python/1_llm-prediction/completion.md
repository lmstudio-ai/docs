---
title: Text Completions
description: "Provide a string input for the model to complete"
---

Use `llm.complete(...)` to generate text completions from a loaded language model.
Text completions mean sending a non-formatted string to the model with the expectation that the model will complete the text.

This is different from multi-turn chat conversations. For more information on chat completions, see [Chat Completions](./chat-completion).

## 1. Instantiate a Model

First, you need to load a model to generate completions from.
This can be done using the top-level `llm` convenience API,
or the `model` method in the `llm` namespace when using the scoped resource API.
For example, here is how to use Qwen2.5 7B Instruct.


```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        model = lms.llm("qwen2.5-7b-instruct")

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms

        with lms.Client() as client:
            model = client.llm.model("qwen2.5-7b-instruct")

    "Python (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        import lmstudio as lms

        async with lms.AsyncClient() as client:
            model = await client.llm.model("qwen2.5-7b-instruct")

```

## 2. Generate a Completion

Once you have a loaded model, you can generate completions by passing a string to the `complete` method on the `llm` handle.

```lms_code_snippet
  variants:
    "Non-streaming (synchronous API)":
      language: python
      code: |
        # The `chat` object is created in the previous step.
        result = model.complete("My name is", config={"maxTokens": 100})

        print(result)

    "Streaming (synchronous API)":
      language: python
      code: |
        # The `chat` object is created in the previous step.
        prediction_stream = model.complete_stream("My name is", config={"maxTokens": 100})

        for fragment in prediction_stream:
            print(fragment.content, end="", flush=True)
        print() # Advance to a new line at the end of the response

    "Non-streaming (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        # The `chat` object is created in the previous step.
        result = await model.complete("My name is", config={"maxTokens": 100})

        print(result)

    "Streaming (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        # The `chat` object is created in the previous step.
        prediction_stream = await model.complete_stream("My name is", config={"maxTokens": 100})

        async for fragment in prediction_stream:
            print(fragment.content, end="", flush=True)
        print() # Advance to a new line at the end of the response

```

## 3. Print Prediction Stats

You can also print prediction metadata, such as the model used for generation, number of generated tokens, time to first token, and stop reason.

```lms_code_snippet
  variants:
    "Non-streaming":
      language: python
      code: |
        # `result` is the response from the model.
        print("Model used:", result.model_info.display_name)
        print("Predicted tokens:", result.stats.predicted_tokens_count)
        print("Time to first token (seconds):", result.stats.time_to_first_token_sec)
        print("Stop reason:", result.stats.stop_reason)

    "Streaming":
      language: python
      code: |
        # After iterating through the prediction fragments,
        # the overall prediction result may be obtained from the stream
        result = prediction_stream.result()

        print("Model used:", result.model_info.display_name)
        print("Predicted tokens:", result.stats.predicted_tokens_count)
        print("Time to first token (seconds):", result.stats.time_to_first_token_sec)
        print("Stop reason:", result.stats.stop_reason)

```

Both the non-streaming and streaming result access is consistent across the synchronous and
asynchronous APIs, as `prediction_stream.result()` is a non-blocking API that raises an exception
if no result is available (either because the prediction is still running, or because the
prediction request failed). Prediction streams also offer a blocking (synchronous API) or
awaitable (asynchronous API) `prediction_stream.wait_for_result()` method that internally handles
iterating the stream to completion before returning the result.

## Example: Get an LLM to Simulate a Terminal

Here's an example of how you might use the `complete` method to simulate a terminal.

```lms_code_snippet
  title: "terminal-sim.py"
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        model = lms.llm()
        console_history = []

        while True:
            try:
                user_command = input("$ ")
            except EOFError:
                print()
                break
            if user_command.strip() == "exit":
                break
            console_history.append(f"$ {user_command}")
            history_prompt = "\n".join(console_history)
            prediction_stream = model.complete_stream(
                history_prompt,
                config={ "stopStrings": ["$"] },
            )
            for fragment in prediction_stream:
                print(fragment.content, end="", flush=True)
            print()
            console_history.append(prediction_stream.result().content)

```

## Customize Inferencing Parameters

You can pass in inferencing parameters via the `config` keyword parameter on `.complete()`.

```lms_code_snippet
  variants:
    "Non-streaming (synchronous API)":
      language: python
      code: |
        result = model.complete(initial_text, config={
            "temperature": 0.6,
            "maxTokens": 50,
        })

    "Streaming (synchronous API)":
      language: python
      code: |
        prediction_stream = model.complete_stream(initial_text, config={
            "temperature": 0.6,
            "maxTokens": 50,
        })

    "Non-streaming (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        result = await model.complete(initial_text, config={
            "temperature": 0.6,
            "maxTokens": 50,
        })

    "Streaming (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        prediction_stream = await model.complete_stream(initial_text, config={
            "temperature": 0.6,
            "maxTokens": 50,
        })

```

See [Configuring the Model](./parameters) for more information on what can be configured.

### Progress Callbacks

Long prompts will often take a long time to first token, i.e. it takes the model a long time to process your prompt.
If you want to get updates on the progress of this process, you can provide a float callback to `complete`
that receives a float from 0.0-1.0 representing prompt processing progress.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        llm = lms.llm()

        completion = llm.complete(
            "My name is",
            on_prompt_processing_progress = (lambda progress: print(f"{progress*100}% complete")),
        )

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms

        with lms.Client() as client:
            llm = client.llm.model()

            completion = llm.complete(
                "My name is",
                on_prompt_processing_progress = (lambda progress: print(f"{progress*100}% processed")),
            )

    "Python (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        import lmstudio as lms

        async with lms.AsyncClient() as client:
            llm = await client.llm.model()

            completion = await llm.complete(
                "My name is",
                on_prompt_processing_progress = (lambda progress: print(f"{progress*100}% processed")),
            )

```

In addition to `on_prompt_processing_progress`, the other available progress callbacks are:

* `on_first_token`: called after prompt processing is complete and the first token is being emitted.
  Does not receive any arguments (use the streaming iteration API or `on_prediction_fragment`
  to process tokens as they are emitted).
* `on_prediction_fragment`: called for each prediction fragment received by the client.
  Receives the same prediction fragments as iterating over the stream iteration API.
* `on_message`: called with an assistant response message when the prediction is complete.
  Intended for appending received messages to a chat history instance.
