---
title: "Text-only Generators"
+description: "Create text-only generators for LM Studio plugins using TypeScript"
index: 2
---

Generators take in the the generator controller and the current conversation state, start the generation, and then report the generated text using the `ctl.fragmentGenerated` method.

The following is an example of a simple generator that echos back the last user message with 200 ms delay between each word:

```lms_code_snippet
  title: "src/toolsProvider.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { Chat, GeneratorController } from "@lmstudio/sdk";

        export async function generate(ctl: GeneratorController, chat: Chat) {
          // Just echo back the last message
          const lastMessage = chat.at(-1).getText();
          // Split the last message into words
          const words = lastMessage.split(/(?= )/);
          for (const word of words) {
            ctl.fragmentGenerated(word); // Send each word as a fragment
            ctl.abortSignal.throwIfAborted(); // Allow for cancellation
            await new Promise((resolve) => setTimeout(resolve, 200)); // Simulate some processing time
          }
        }
```

## Custom Configurations

You can access custom configurations via `ctl.getPluginConfig` and `ctl.getGlobalPluginConfig`. See [Custom Configurations](./configurations) for more details.

## Handling Aborts

A prediction may be aborted by the user while your generator is still running. In such cases, you should handle the abort gracefully by handling the `ctl.abortSignal`.

You can learn more about `AbortSignal` in the [MDN documentation](https://developer.mozilla.org/en-US/docs/Web/API/AbortSignal).
