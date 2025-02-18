---
title: Text Completion
description: "Provide a string input for the model to complete"
---

## Overview

Once you have [downloaded and loaded](/docs/basics/index) a large language model,
you can use it to respond to input through the API. This article covers generating simple
string completions, but you can also
[request chat responses](/docs/api/sdk/chat-completion),
[use a vision-language model to chat about images](/docs/api/sdk/image-input), and
[get JSON structured output for programmatic use](/docs/api/sdk/structured-response).

### Usage

To get a simple string completion from a loaded LLM, e.g. "The cat in the" -> "hat",
pass the string to be completed to the `complete` method on the corresponding LLM handle.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()

        # You can either request the response token-by-token,
        # which will only return new tokens...
        prediction = llm.complete_stream("My name is")
        for token in prediction:
            print(token, end="", flush=True)

        # ...or request the whole thing at once,
        # which will return the completed string.
        completion = llm.complete("My name is")
        print(completion)

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()

            # You can either request the response token-by-token,
            # which will only return new tokens...
            prediction = llm.complete_stream("My name is")
            for token in prediction:
                print(token, end="", flush=True)

            # ...or request the whole thing at once,
            # which will return the completed string.
            completion = llm.complete("My name is")
            print(completion)

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.model();

        const prediction = llm.complete("My name is");
        for await (const { content } of prediction) {
          process.stdout.write(content);
        }

```

## Advanced Usage

### Prediction metadata

Prediction responses are really returned as `PredictionResult` objects that contain additional dot-accessible metadata about the inference request.
This entails info about the model used, the configuration with which it was loaded, and the configuration for this particular prediction. It also provides
inference statistics like stop reason, time to first token, tokens per second, and number of generated tokens.

Please consult your specific SDK to see exact syntax.

### Callbacks

TODO

### Prediction configuration

You can also specify the same prediction configuration options as you could in the
in-app chat window sidebar. Please consult your specific SDK to see exact syntax.
