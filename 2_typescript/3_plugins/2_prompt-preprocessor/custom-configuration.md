---
title: "Custom Configuration"
+description: "Access custom configuration options in your prompt preprocessor"
index: 3
---

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
