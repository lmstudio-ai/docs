---
title: The `.act()` call
description: How to use the `.act()` call to turn LLMs into autonomous agents that can perform tasks on your local machine.
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
        await model.act("What is the result of 12345 multiplied by 54321?", [multiplyTool], {
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

### Example: Multiple Tools

The following code demonstrates how to provide multiple tools in a single `.act()` call.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient, tool } from "@lmstudio/sdk";
        import { z } from "zod";

        const client = new LMStudioClient();

        const additionTool = tool({
          name: "add",
          description: "Given two numbers a and b. Returns the sum of them.",
          parameters: { a: z.number(), b: z.number() },
          implementation: ({ a, b }) => a + b,
        });

        const isPrimeTool = tool({
          name: "isPrime",
          description: "Given a number n. Returns true if n is a prime number.",
          parameters: { n: z.number() },
          implementation: ({ n }) => {
            if (n < 2) return false;
            const sqrt = Math.sqrt(n);
            for (let i = 2; i <= sqrt; i++) {
              if (n % i === 0) return false;
            }
            return true;
          },
        });

        const model = await client.llm.model("qwen2.5-7b-instruct");
        await model.act(
          "Is the result of 12345 + 45668 a prime? Think step by step.",
          [additionTool, isPrimeTool],
          { onMessage: (message) => console.info(message.toString()) },
        );
```

### Example: Chat Loop with Create File Tool

The following code creates a conversation loop with an LLM agent that can create files.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { Chat, LMStudioClient, tool } from "@lmstudio/sdk";
        import { existsSync } from "fs";
        import { writeFile } from "fs/promises";
        import { createInterface } from "readline/promises";
        import { z } from "zod";

        const rl = createInterface({ input: process.stdin, output: process.stdout });
        const client = new LMStudioClient();
        const model = await client.llm.model();
        const chat = Chat.empty();

        const createFileTool = tool({
          name: "createFile",
          description: "Create a file with the given name and content.",
          parameters: { name: z.string(), content: z.string() },
          implementation: async ({ name, content }) => {
            if (existsSync(name)) {
              return "Error: File already exists.";
            }
            await writeFile(name, content, "utf-8");
            return "File created.";
          },
        });

        while (true) {
          const input = await rl.question("You: ");
          // Append the user input to the chat
          chat.append("user", input);

          process.stdout.write("Bot: ");
          await model.act(chat, [createFileTool], {
            // When the model finish the entire message, push it to the chat
            onMessage: (message) => chat.append(message),
            onPredictionFragment: ({ content }) => {
              process.stdout.write(content);
            },
          });
          process.stdout.write("\n");
        }
```
