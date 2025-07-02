---
title: "Prompt Preprocessors"
description: "Writing prompt preprocessors for LM Studio plugins using TypeScript"
index: 3
---

```lms_private_beta
Plugin support is currently in private beta. [Join the beta here](https://forms.gle/ZPfGLMvVC6DbSRQm9).
```

Prompt Preprocessor is a function that is called upon the user hitting the "Send" button. It receives the user input and can modify it before it reaches the model. If multiple prompt preprocessors are registered, they will be chained together, with each one receiving the output of the previous one.

The modified result will be saved in the chat history, meaning that even if your plugin is disabled afterwards, the modified input will still be used.

Prompt preprocessors will only be triggered for the current user input. It will not be triggered for previous messages in the chat history even if they were not preprocessed.

Prompt preprocessors takes in a `ctl` object for controlling the preprocessing and a `userMessage` it needs to preprocess. It returns either a string or a message object which will replace the user message.

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

### Custom Configurations

You can access custom configurations via `ctl.getPluginConfig` and `ctl.getGlobalPluginConfig`. See [Custom Configurations](./configurations) for more details.

The following is an example of how you can make the `specialInstructions` and `triggerWord` configurable:

First, add the config field to `config.ts`:

```lms_code_snippet
  title: "src/config.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { createConfigSchematics } from "@lmstudio/sdk";
        export const configSchematics = createConfigSchematics()
          .field(
            "specialInstructions",
            "string",
            {
              displayName: "Special Instructions",
              subtitle: "Special instructions to be injected when the trigger word is found.",
            },
            "Here is some default special instructions.",
          )
          .field(
            "triggerWord",
            "string",
            {
              displayName: "Trigger Word",
              subtitle: "The word that will trigger the special instructions.",
            },
            "@init",
          )
          .build();
```

```lms_info
In this example, we added the field to `configSchematics`, which is the "per-chat" configuration. If you want to add a global configuration field that is shared across different chats, you should add it under the section `globalConfigSchematics` in the same file.

Learn more about configurations in [Custom Configurations](../plugins/configurations).
```

Then, modify the prompt preprocessor to use the configuration:

```lms_code_snippet
  title: "src/promptPreprocessor.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { type PromptPreprocessorController, type ChatMessage } from "@lmstudio/sdk";
        import { configSchematics } from "./config";

        export async function preprocess(ctl: PromptPreprocessorController, userMessage: ChatMessage) {
          const textContent = userMessage.getText();
          const pluginConfig = ctl.getPluginConfig(configSchematics);

          const triggerWord = pluginConfig.get("triggerWord");
          const specialInstructions = pluginConfig.get("specialInstructions");

          const transformed = textContent.replaceAll(triggerWord, specialInstructions);
          return transformed;
        }
```

### Custom Status Reporting

Depending on the task, the prompt preprocessor may take some time to complete, for example, it may need to fetch some data from the internet or perform some heavy computation. In such cases, you can report the status of the preprocessing using `ctl.setStatus`.

```lms_code_snippet
  title: "src/promptPreprocessor.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        const status = ctl.createStatus({
          status: "loading",
          text: "Preprocessing.",
        });
```

You can update the status at any time by calling `status.setState`.

```lms_code_snippet
  title: "src/promptPreprocessor.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        status.setState({
          status: "done",
          text: "Preprocessing done.",
        })
```

You can even add sub status to the status:

```lms_code_snippet
  title: "src/promptPreprocessor.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        const subStatus = status.addSubStatus({
          status: "loading",
          text: "I am a sub status."
        });
```

## Handling Aborts

A prediction may be aborted by the user while your generator is still running. In such cases, you should handle the abort gracefully by handling the `ctl.abortSignal`.

You can learn more about `AbortSignal` in the [MDN documentation](https://developer.mozilla.org/en-US/docs/Web/API/AbortSignal).

### Examples

The following are some plugins that make use of prompt preprocessors:

- [lmstudio/rag-v1](https://lmstudio.ai/lmstudio/rag-v1)

  Retrieval Augmented Generation (RAG) for LM Studio. This is the plugin that gives document handling capabilities to LM Studio.
