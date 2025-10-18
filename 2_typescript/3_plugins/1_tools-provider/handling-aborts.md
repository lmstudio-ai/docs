---
title: "Handling Aborts"
description: "Gracefully handle user-aborted tool executions in your tools provider"
index: 7
---

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
