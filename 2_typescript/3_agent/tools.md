---
title: Tool Definition
description: Define tools with the `tool()` function and pass them to the model in the `act()` call.
index: 2
---

You can define tools with the `tool()` function and pass them to the model in the `act()` call.

## Anatomy of a Tool

Follow this standard format to define functions as tools:

```lms_code_snippet
  title: "index.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { tool } from "@lmstudio/sdk";
        import { z } from "zod";

        const exampleTool = tool({
          // The name of the tool
          name: "add",

          // A description of the tool
          description: "Given two numbers a and b. Returns the sum of them.",

          // zod schema of the parameters
          parameters: { a: z.number(), b: z.number() },

          // The implementation of the tool. Just a regular function.
          implementation: ({ a, b }) => a + b,
        });
```

**Important**: The tool name, description, and the parameter definitions are all passed to the model!

This means that your wording will affect the quality of the generation. Make sure to always provide a clear description of the tool so the model knows how to use it.

## Tools with External Effects (like Computer Use or API Calls)

Tools can also have external effects, such as creating files or calling programs and even APIs. By implementing tools with external effects, you
can essentially turn your LLMs into autonomous agents that can perform tasks on your local machine.

## Example: `createFileTool`

### Tool Definition

```lms_code_snippet
  title: "createFileTool.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { tool } from "@lmstudio/sdk";
        import { existsSync } from "fs";
        import { writeFile } from "fs/promises";
        import { z } from "zod";

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
```

### Example code using the `createFile` tool:

```lms_code_snippet
  title: "index.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";
        import { createFileTool } from "./createFileTool";

        const client = new LMStudioClient();

        const model = await client.llm.model("qwen2.5-7b-instruct");
        await model.act(
          "Please create a file named output.txt with your understanding of the meaning of life.",
          [createFileTool],
        );
```
