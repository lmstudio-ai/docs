---
title: "Status Reports & Warnings"
+description: "Report status updates and warnings during tool execution in your tools provider"
index: 6
---

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
