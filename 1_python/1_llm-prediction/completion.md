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

```

## 2. Generate a Completion

Once you have a loaded model, you can generate completions by passing a string to the `complete` method on the `llm` handle.

```lms_code_snippet
  variants:
    Streaming:
      language: python
      code: |
        # The `chat` object is created in the previous step.
        prediction_stream = model.complete_stream("My name is")

        for fragment in prediction_stream:
            print(fragment.content, end="", flush=True)
        print() # Advance to a new line at the end of the response

    "Non-streaming":
      language: python
      code: |
        # The `chat` object is created in the previous step.
        result = model.complete("My name is")

        print(result)
```

## 3. Print Prediction Stats

You can also print prediction metadata, such as the model used for generation, number of generated tokens, time to first token, and stop reason.

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

## Example: Get an LLM to Simulate a Terminal

Here's an example of how you might use the `complete` method to simulate a terminal.

```lms_code_snippet
  title: "terminal-sim.py"
  variants:
    Python:
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

<!-- ## Advanced Usage

### Progress callbacks

TODO: Cover available callbacks (Python SDK has all of these now)

Long prompts will often take a long time to first token, i.e. it takes the model a long time to process your prompt.
If you want to get updates on the progress of this process, you can provide a float callback to `complete`
that receives a float from 0.0-1.0 representing prompt processing progress.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lms

        llm = lms.llm()

        completion = llm.complete(
            "My name is",
            on_progress: lambda progress: print(f"{progress*100}% complete")
        )

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio as lms

        with lms.Client() as client:
            llm = client.llm.model()

            completion = llm.complete(
                "My name is",
                on_progress: lambda progress: print(f"{progress*100}% processed")
            )

    "Python (convenience API)":
      language: python
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient()
        const llm = client.llm.model()

        const prediction = llm.complete(
          "My name is",
          {onPromptProcessingProgress: (progress) => process.stdout.write(`${progress*100}% processed`)})
```

### Prediction configuration

You can also specify the same prediction configuration options as you could in the
in-app chat window sidebar. Please consult your specific SDK to see exact syntax. -->
