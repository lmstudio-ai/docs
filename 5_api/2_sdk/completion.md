---
title: Text Completion
description: "Provide a string input for the model to complete"
---

Explanation explanation explanation explanation explanation explanation explanation.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()
        prediction = llm.complete_stream("My name is")
        for token in prediction:
            print(token, end="", flush=True)
        # The entire completion can also be requested at once
        completion = llm.complete("I have an interest in")

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()
            prediction = llm.complete_stream("My name is")
            for token in prediction:
                print(token, end="", flush=True)
            # The entire completion can also be requested at once
            completion = llm.complete("I have an interest in")

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
