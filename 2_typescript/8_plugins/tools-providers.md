---
title: "Tools Providers"
description: "Writing tools providers for LM Studio plugins using TypeScript"
index: 2
---

```lms_private_beta
Plugin support is currently in private beta. [Join the beta here](https://forms.gle/ZPfGLMvVC6DbSRQm9).
```

Tools provider is a function that returns an array of tools that the model can use during generation.

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

## Multiple Tools

A tools provider can define multiple tools for the model to use. Simply create additional tool instances and add them to the tools array.

In the example below, we add a second tool to read the content of a file:

```lms_code_snippet
  title: "src/toolsProvider.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { tool, Tool, ToolsProviderController } from "@lmstudio/sdk";
        import { z } from "zod";
        import { existsSync } from "fs";
        import { readFile, writeFile } from "fs/promises";
        import { join } from "path";

        export async function toolsProvider(ctl: ToolsProviderController) {
          const tools: Tool[] = [];

          const createFileTool = tool({
            name: `create_file`,
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
          tools.push(createFileTool); // First tool

          const readFileTool = tool({
            name: `read_file`,
            description: "Read the content of a file with the given name.",
            parameters: { file_name: z.string() },
            implementation: async ({ file_name }) => {
              const filePath = join(ctl.getWorkingDirectory(), file_name);
              if (!existsSync(filePath)) {
                return "Error: File does not exist.";
              }
              const content = await readFile(filePath, "utf-8");
              return content;
            },
          });
          tools.push(readFileTool); // Second tool

          return tools; // Return the tools array
        }
```

## Custom Configuration

You can add custom configuration options to your tools provider, so the user of plugin can customize the behavior without modifying the code.

In the example below, we will ask the user to specify a folder name, and we will create files inside that folder within the working directory.

First, add the config field to `config.ts`:

```lms_code_snippet
  title: "src/config.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        export const configSchematics = createConfigSchematics()
          .field(
            "folderName", // Key of the configuration field
            "string", // Type of the configuration field
            {
              displayName: "Folder Name",
              subtitle: "The name of the folder where files will be created.",
            },
            "default_folder", // Default value
          )
          .build();
```

```lms_info
In this example, we added the field to `configSchematics`, which is the "per-chat" configuration. If you want to add a global configuration field that shared across different chats, you should add it under the section `globalConfigSchematics` in the same file.

Learn more about configurations in [Custom Configurations](../plugins/configurations).
```

Then, modify the tools provider to use the configuration value:

```lms_code_snippet
  title: "src/toolsProvider.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { tool, Tool, ToolsProviderController } from "@lmstudio/sdk";
        import { existsSync } from "fs";
        import { mkdir, writeFile } from "fs/promises";
        import { join } from "path";
        import { z } from "zod";
        import { configSchematics } from "./config";

        export async function toolsProvider(ctl: ToolsProviderController) {
          const tools: Tool[] = [];

          const createFileTool = tool({
            name: `create_file`,
            description: "Create a file with the given name and content.",
            parameters: { file_name: z.string(), content: z.string() },
            implementation: async ({ file_name, content }) => {
              // Read the config field
              const folderName = ctl.getPluginConfig(configSchematics).get("folderName");
              const folderPath = join(ctl.getWorkingDirectory(), folderName);

              // Ensure the folder exists
              await mkdir(folderPath, { recursive: true });

              // Create the file
              const filePath = join(folderPath, file_name);
              if (existsSync(filePath)) {
                return "Error: File already exists.";
              }
              await writeFile(filePath, content, "utf-8");
              return "File created.";
            },
          });
          tools.push(createFileTool); // First tool

          return tools; // Return the tools array
        }
```

## Status Reports & Warnings

Sometimes, a tool may take a long time to execute. In such cases, it will be helpful to provide status updates, so the user knows what is happening. In order times, you may want to warn the user about potential issues.

You can use `status` and `warn` methods on the second parameter of the tool's implementation function to send status updates and warnings.

The following example shows how to implement a tool that waits for a specified number of seconds, providing status updates and warnings if the wait time exceeds 10 seconds:

```lms_code_snippet
  title: "src/toolsProvider.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { tool, Tool, ToolsProviderController } from "@lmstudio/sdk";
        import { z } from "zod";

        export async function toolsProvider(ctl: ToolsProviderController) {
          const tools: Tool[] = [];

          const waitTool = tool({
            name: `wait`,
            description: "Wait for a specified number of seconds.",
            parameters: { seconds: z.number().min(1) },
            implementation: async ({ seconds }, { status, warn }) => {
              if (seconds > 10) {
                warn("The model asks to wait for more than 10 seconds.");
              }
              for (let i = 0; i < seconds; i++) {
                status(`Waiting... ${i + 1}/${seconds} seconds`);
                await new Promise((resolve) => setTimeout(resolve, 1000));
              }
            },
          });
          tools.push(waitTool);

          return tools; // Return the tools array
        }
```

Note status updates and warnings are only visible to the user. If you want the model to also see those messages, you should return them as part of the tool's return value.

## Handling Aborts

A prediction may be aborted by the user while your tool is still running. In such cases, you should handle the abort gracefully by handling the `AbortSignal` object passed as the second parameter to the tool's implementation function.

```lms_code_snippet
  title: "src/toolsProvider.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { tool, Tool, ToolsProviderController } from "@lmstudio/sdk";
        import { z } from "zod";

        export async function toolsProvider(ctl: ToolsProviderController) {
          const tools: Tool[] = [];

          const fetchTool = tool({
            name: `fetch`,
            description: "Fetch a URL using GET method.",
            parameters: { url: z.string() },
            implementation: async ({ url }, { signal }) => {
              const response = await fetch(url, {
                method: "GET",
                signal, // <-- Here, we pass the signal to fetch to allow cancellation
              });
              if (!response.ok) {
                return `Error: Failed to fetch ${url}: ${response.statusText}`;
              }
              const data = await response.text();
              return {
                status: response.status,
                headers: Object.fromEntries(response.headers.entries()),
                data: data.substring(0, 1000), // Limit to 1000 characters
              };
            },
          });
          tools.push(fetchTool);

          return tools;
        }
```

You can learn more about `AbortSignal` in the [MDN documentation](https://developer.mozilla.org/en-US/docs/Web/API/AbortSignal).

## Tips

- **Use Descriptive Names and Descriptions**: When defining tools, use descriptive names and detailed descriptions. This helps the model understand when and how to use each tool effectively.
- **Return Errors as Strings**: Sometimes, the model may make a mistake when calling a tool. In such cases, you can return an error message as a string. In most cases, the model will try to correct itself and call the tool again with the correct parameters.

## Examples

The following are some plugins that make use of tools providers:

- [lmstudio/wikipedia](https://lmstudio.ai/lmstudio/wikipedia)

  Gives the LLM tools to search and read Wikipedia articles.

- [lmstudio/js-code-sandbox](https://lmstudio.ai/lmstudio/js-code-sandbox)

  Gives the LLM tools to run JavaScript/TypeScript code in a sandbox environment using [deno](https://deno.com/).

- [lmstudio/dice](https://lmstudio.ai/lmstudio/dice)

  Allows the LLM to generate random numbers using "dice".
