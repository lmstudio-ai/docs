---
title: The `.operate()` call
description: TODO...
index: 2
---

## Agents

LLMs are text-in text-out models and cannot directly execute code. However, just like an ancient general can command an army with their voices alone, if we ask the LLM to output text in a certain format when it wants to use an external tool, and execute those requests on its behave, we can effectively turn LLMs into autonomous agents that can perform tasks on your local machine.

### Quick Example

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient, tool } from "@lmstudio/sdk";
        import { z } from "zod";

        const client = new LMStudioClient();

        const multiplyTool = tool({
          name: "multiply",
          description: "Given two numbers a and b. Returns the product of them.",
          parameters: { a: z.number(), b: z.number() },
          implementation: ({ a, b }) => a * b,
        });

        const model = await client.llm.model("qwen2.5-7b-instruct");
        await model.operate("What is the result of 12345 multiplied by 54321?", [multiplyTool], {
          onMessage: (message) => console.info(message.toString()),
        });
```

### Important: Model Selection

The model selected for tool use will greatly impact performance.

Some general guidance when selecting a model:

- Not all models are capable of intelligent tool use
- Bigger is better (i.e., a 7B parameter model will generally perform better than a 3B parameter model)
- We've observed [Qwen2.5-7B-Instruct](https://model.lmstudio.ai/download/lmstudio-community/Qwen2.5-7B-Instruct-GGUF) to perform well in a wide variety of cases
- This guidance may change

###

```

```
