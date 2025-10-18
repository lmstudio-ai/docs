---
title: "Examples"
+description: "Example prompt preprocessors for LM Studio plugins"
index: 2
---

### Example: Inject Current Time

The following is an example preprocessor that injects the current time before each user message.

```lms_code_snippet
  title: "src/promptPreprocessor.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { type PromptPreprocessorController, type ChatMessage } from "@lmstudio/sdk";
        export async function preprocess(ctl: PromptPreprocessorController, userMessage: ChatMessage) {
          const textContent = userMessage.getText();
          const transformed = `Current time: ${new Date().toString()}\n\n${textContent}`;
          return transformed;
        }
```

### Example: Replace Trigger Words

Another example you can do it with simple text only processing is by replacing certain trigger words. For example, you can replace a `@init` trigger with a special initialization message.

```lms_code_snippet
  title: "src/promptPreprocessor.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { type PromptPreprocessorController, type ChatMessage, text } from "@lmstudio/sdk";

        const mySpecialInstructions = text`
          Here are some special instructions...
        `;

        export async function preprocess(ctl: PromptPreprocessorController, userMessage: ChatMessage) {
          const textContent = userMessage.getText();
          const transformed = textContent.replaceAll("@init", mySpecialInstructions);
          return transformed;
        }
```
