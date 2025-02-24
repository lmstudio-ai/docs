---
title: Chat Completion
description: Provide a chat context for the model to respond to
---

TODO Regular text

## Quick Example

ryan: single string respond

## Obtaining a Model

First, you need to load a model to generate completions from. This can be done using the `model` method in the `llm` namespace. TODO: Link: model init

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

## Manage Chat Context

1. show this
   context = Chat.from([
   { role: "system", content: "You are a resident AI philosopher." },
   { role: "user", content: "What is the meaning of life?" },
   ])
2. context builder
   ...

## Generate a response

Once you have a loaded model, you can ask the model to continue a conversation using the `respond`
method on the `llm` instance. TODO Link: working with chats

```lms_code_snippet
  variants:
    Streaming:
      language: typescript
      code: |
        const prediction = llm.respond([
          { role: "system", content: "You are a resident AI philosopher." },
          { role: "user", content: "What is the meaning of life?" },
        ]);

        for await (const { content } of prediction) {
          process.stdout.write(content);
        }

        console.info(); // Write a new line to prevent text from being overwritten by your shell.

    "Non-streaming":
      language: typescript
      code: |
        const prediction = await llm.respond([
          { role: "system", content: "You are a resident AI philosopher." },
          { role: "user", content: "What is the meaning of life?" },
        ]);

        console.info(prediction.content);
```

## Customize Inferencing Parameters

show streaming one

## Print prediction stats

You can also print prediction metadata, such as the model used for generation, number of generated
tokens, time to first token, and stop reason.

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
