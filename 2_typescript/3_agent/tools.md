---
title: Tool Definition
description: TODO...
index: 1
---

## Quick Example

You can define tools with the `tool` function.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { tool } from "@lmstudio/sdk";
        import { z } from "zod";

        const addTool = tool({
          name: "add",
          description: "Given two numbers a and b. Returns the sum of them.",
          parameters: { a: z.number(), b: z.number() },
          implementation: ({ a, b }) => a + b,
        });
```

The name, description, and the parameter definitions are all passed to the model. Thus, your wording
will affect the quality of the generation. Make sure to always provide a clear description of the
tool so the model knows how to use it.

## Example: Creating Files

Tools can also have side effects, such as creating files. By providing tools with side effects, you
can essentially turn your LLMs into autonomous agents that can perform tasks on your local machine.

Here is an example tool that creates a file:

```lms_code_snippet
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

Example code using the `createFile` tool:

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";
        const client = new LMStudioClient();

        const model = await client.llm.model("qwen2.5-7b-instruct");
        await model.operate(
          "Please create a file output.txt with your understanding of the meaning of life.",
          [createFileTool],
        );
```
