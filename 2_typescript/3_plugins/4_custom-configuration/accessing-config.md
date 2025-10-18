---
title: "Accessing Configuration"
+description: "Access custom configuration options in your LM Studio plugin"
index: 3
---

You can access the configuration using the method `ctl.getPluginConfig(configSchematics)` and `ctl.getGlobalConfig(globalConfigSchematics)` respectively.

For example, here is how to access the config within the promptPreprocessor:

```lms_code_snippet
  title: "src/promptPreprocessor.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { type PreprocessorController, type ChatMessage } from "@lmstudio/sdk";
        import { configSchematics } from "./config";

        export async function preprocess(ctl: PreprocessorController, userMessage: ChatMessage) {
          const pluginConfig = ctl.getPluginConfig(configSchematics);
          const myCustomField = pluginConfig.get("myCustomField");

          const globalPluginConfig = ctl.getGlobalPluginConfig(configSchematics);
          const globalMyCustomField = globalPluginConfig.get("myCustomField");

          return (
            `${userMessage.getText()},` +
            `myCustomField: ${myCustomField}, ` +
            `globalMyCustomField: ${globalMyCustomField}`
          );
        }
```
