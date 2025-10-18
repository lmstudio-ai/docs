---
title: "Custom Configuration"
description: "Add custom configuration options to your tools provider"
index: 5
---

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
In this example, we added the field to `configSchematics`, which is the "per-chat" configuration. If you want to add a global configuration field that is shared across different chats, you should add it under the section `globalConfigSchematics` in the same file.

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
