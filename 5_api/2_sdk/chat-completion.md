---
title: Chat Completion
description: Provide a chat context for the model to respond to
---

Explanation explanation explanation explanation explanation explanation explanation.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()
        prediction = llm.respond_stream("I have a problem, can you help?")
        for token in prediction:
            print(token, end="", flush=True)
        # The entire response can also be requested at once
        response = llm.respond("I have a question, can you help?")

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio as lm

        with lm.Client() as client:
          llm = lm.llm.get()
          prediction = llm.respond_stream("My name is")
          for token in prediction:
              print(token, end="", flush=True)
          # The entire response can also be requested at once
          response = llm.respond("I have a question, can you help?")

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.getAny();
        const prediction = llm.respond("I have a problem, can you help?");
        for await (const { content } of prediction) {
          process.stdout.write(content);
        }

```
