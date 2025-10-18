---
title: "Single Tool"
+description: "Set up a tools provider with a single tool in your LM Studio plugin"
index: 3
---

To setup a tools provider, first create the a file `toolsProvider.ts` in your plugin's `src` directory:

```lms_code_snippet
  title: "src/toolsProvider.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { tool, Tool, ToolsProviderController } from "@lmstudio/sdk";
        import { z } from "zod";
        import { existsSync } from "fs";
        import { writeFile } from "fs/promises";
        import { join } from "path";

        export async function toolsProvider(ctl: ToolsProviderController) {
          const tools: Tool[] = [];

          const createFileTool = tool({
            // Name of the tool, this will be passed to the model. Aim for concise, descriptive names
            name: `create_file`,
            // Your description here, more details will help the model to understand when to use the tool
            description: "Create a file with the given name and content.",
            parameters: { file_name: z.string(), content: z.string() },
            implementation: async ({ file_name, content }) => {
              const filePath = join(ctl.getWorkingDirectory(), file_name);
              if (existsSync(filePath)) {
                return "Error: File already exists.";
              }
              await writeFile(filePath, content, "utf-8");
              return "File created.";
            },
          });
          tools.push(createFileTool);

          return tools;
        }
```

The above tools provider defines a single tool called `create_file` that allows the model to create a file with a specified name and content inside the working directory. You can learn more about defining tools in [Tool Definition](../agent/tools).

Then register the tools provider in your plugin's `index.ts`:

```lms_code_snippet
  title: "src/index.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        // ... other imports ...
        import { toolsProvider } from "./toolsProvider";

        export async function main(context: PluginContext) {
          // ... other plugin setup code ...

          // Register the tools provider.
          context.withToolsProvider(toolsProvider); // <-- Register the tools provider

          // ... other plugin setup code ...
        }
```

Now, you can try to ask the LLM to create a file, and it should be able to do so using the tool you just created.

## Tips

- **Use Descriptive Names and Descriptions**: When defining tools, use descriptive names and detailed descriptions. This helps the model understand when and how to use each tool effectively.
- **Return Errors as Strings**: Sometimes, the model may make a mistake when calling a tool. In such cases, you can return an error message as a string. In most cases, the model will try to correct itself and call the tool again with the correct parameters.
