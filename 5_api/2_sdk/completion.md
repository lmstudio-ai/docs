---
title: Text Completion
description: "Provide a string input for the model to complete"
---

Once you have [downloaded and loaded](/docs/1_basics/index) a large language model,
you can use it to respond to input through the API. This article covers generating simple
string completions, but you can also
[request chat responses](/docs/5_api/2_sdk/chat-completion),
[use a vision-language model to chat about images](/docs/5_api/2_sdk/image-input), and
[get JSON structured output for programmatic use](/docs/5_api/2_sdk/structured-response).

To get a simple string completion from a loaded LLM, e.g. "The cat in the" -> "hat",
use the `complete` method on the corresponding LLM handle.

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

TODO - copy from chat completion

### Prediction configuration

TODO - copy from chat completion
