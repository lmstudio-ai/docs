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
        response = llm.complete_stream("My name is")
        for token in response:
            print(token, end="", flush=True)

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.getAny();
        const prediction = llm.complete("My name is");
        for await (const { content } of prediction) {
          process.stdout.write(content);
        }

```
