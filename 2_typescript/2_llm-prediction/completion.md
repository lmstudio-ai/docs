---
title: Generate Completions
description: "Provide a string input for the model to complete"
index: 6
---

Use `llm.complete(...)` to generate text completions from a loaded language model. Text completions mean sending an non-formatted string to the model with the expectation that the model will complete the text.

This is different from multi-turn chat conversations. For more information on chat completions, see [Chat Completions](./chat-completion).

## 1. Instantiate a Model

First, you need to load a model to generate completions from. This can be done using the `model` method on the `llm` handle.

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

## 2. Generate a Completion

Once you have a loaded model, you can generate completions by passing a string to the `complete` method on the `llm` handle.

```lms_code_snippet
  variants:
    Streaming:
      language: typescript
      code: |
        const completion = model.complete("My name is", {
          maxTokens: 100,
        });

        for await (const { content } of completion) {
          process.stdout.write(content);
        }

        console.info(); // Write a new line for cosmetic purposes

    "Non-streaming":
      language: typescript
      code: |
        const completion = await model.complete("My name is", {
          maxTokens: 100,
        });

        console.info(completion.content);
```

## 3. Print Prediction Stats

You can also print prediction metadata, such as the model used for generation, number of generated tokens, time to first token, and stop reason.

```lms_code_snippet
  title: "index.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        console.info("Model used:", completion.modelInfo.displayName);
        console.info("Predicted tokens:", completion.stats.predictedTokensCount);
        console.info("Time to first token (seconds):", completion.stats.timeToFirstTokenSec);
        console.info("Stop reason:", completion.stats.stopReason);
```

## Example: Get an LLM to Simulate a Terminal

Here's an example of how you might use the `complete` method to simulate a terminal.

```lms_code_snippet
  title: "terminal-sim.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";
        import { createInterface } from "node:readline/promises";

        const rl = createInterface({ input: process.stdin, output: process.stdout });
        const client = new LMStudioClient();
        const model = await client.llm.model();
        let history = "";

        while (true) {
          const command = await rl.question("$ ");
          history += "$ " + command + "\n";

          const prediction = model.complete(history, { stopStrings: ["$"] });
          for await (const { content } of prediction) {
            process.stdout.write(content);
          }
          process.stdout.write("\n");

          const { content } = await prediction.result();
          history += content;
        }
```

<!-- ## Advanced Usage

### Prediction metadata

Prediction responses are really returned as `PredictionResult` objects that contain additional dot-accessible metadata about the inference request.
This entails info about the model used, the configuration with which it was loaded, and the configuration for this particular prediction. It also provides
inference statistics like stop reason, time to first token, tokens per second, and number of generated tokens.

Please consult your specific SDK to see exact syntax.

### Progress callbacks

TODO: TS has onFirstToken callback which Python does not

Long prompts will often take a long time to first token, i.e. it takes the model a long time to process your prompt.
If you want to get updates on the progress of this process, you can provide a float callback to `complete`
that receives a float from 0.0-1.0 representing prompt processing progress.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()

        completion = llm.complete(
            "My name is",
            on_progress: lambda progress: print(f"{progress*100}% complete")
        )

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()

            completion = llm.complete(
                "My name is",
                on_progress: lambda progress: print(f"{progress*100}% processed")
            )

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.model();

        const prediction = llm.complete(
          "My name is",
          {onPromptProcessingProgress: (progress) => process.stdout.write(`${progress*100}% processed`)});
```

### Prediction configuration

You can also specify the same prediction configuration options as you could in the
in-app chat window sidebar. Please consult your specific SDK to see exact syntax. -->
