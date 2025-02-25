---
title: Text Completions
description: "Provide a string input for the model to complete"
---

Use `llm.complete(...)` to generate text completions from a loaded language model.

## 1. Instantiate a model

First, you need to load a model to generate completions from. This can be done using the `model` method on the `llm` handle.

```lms_code_snippet
  title: "index.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.model("qwen2.5-7b-instruct");
```

## 2. Generate a completion

Once you have a loaded model, you can generate completions by passing a string to the `complete` method on the `llm` handle.

```lms_code_snippet
  variants:
    Streaming:
      language: typescript
      code: |
        const completion = llm.complete("My name is");

        for await (const { content } of completion) {
          process.stdout.write(content);
        }

        console.info(); // Write a new line to prevent text from being overwritten by your shell.

    "Non-streaming":
      language: typescript
      code: |
        const completion = await llm.complete("My name is");

        console.info(completion.content);
```

## 3. Print prediction stats

You can also print prediction metadata, such as the model used for generation, number of generated tokens, time to first token, and stop reason.

```lms_code_snippet
  title: "index.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        console.info("Model used:", prediction.modelInfo.displayName);
        console.info("Predicted tokens:", prediction.stats.predictedTokensCount);
        console.info("Time to first token (seconds):", prediction.stats.timeToFirstTokenSec);
        console.info("Stop reason:", prediction.stats.stopReason);
```

## Example: Get an LLM to simulate a terminal

Here's an example of how you might use the `complete` method to simulate a terminal.

```lms_code_snippet
  title: "terminal-sim.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";
        import * as readline from 'readline';

        async function simulateTerminal() {
          const client = new LMStudioClient();
          const llm = await client.llm.model();

          // Create readline interface
          const rl = readline.createInterface({
            input: process.stdin,
            output: process.stdout
          });

          let history = '';

          while (true) {
            // Get user input
            const command = await new Promise<string>(resolve => {
              rl.question('$ ', resolve);
            });

            if (command.toLowerCase() === 'exit') {
              rl.close();
              break;
            }

            // Add command to history
            history += `$ ${command}\n`;

            // Generate completion
            const completion = llm.complete(history, { stop: "$" });

            // Print response
            for await (const { content } of completion) {
              process.stdout.write(content);
            }
            process.stdout.write('\n');

            // Add response to history
            history += completion + '\n';
          }
        }

        simulateTerminal().catch(console.error);
```

## Advanced Usage

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
in-app chat window sidebar. Please consult your specific SDK to see exact syntax.
