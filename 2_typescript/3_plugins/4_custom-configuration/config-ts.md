---
title: "`config.ts` File"
+description: "Define custom configuration options for your LM Studio plugin in config.ts"
index: 2
---

By default, the plugin scaffold will create a `config.ts` file in the `src/` directory which will contain the schematics of the configurations. If the files does not exist, you can create it manually:

```lms_code_snippet
  title: "src/toolsProvider.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { createConfigSchematics } from "@lmstudio/sdk";

        export const configSchematics = createConfigSchematics()
          .field(
            "myCustomField", // The key of the field.
            "numeric", // Type of the field.
            // Options for the field. Different field types will have different options.
            {
              displayName: "My Custom Field",
              hint: "This is my custom field. Doesn't do anything special.",
              slider: { min: 0, max: 100, step: 1 }, // Add a slider to the field.
            },
            80, // Default Value
          )
          // You can add more fields by chaining the field method.
          // For example:
          //   .field("anotherField", ...)
          .build();

        export const globalConfigSchematics = createConfigSchematics()
          .field(
            "myGlobalCustomField", // The key of the field.
            "string",
            {
              displayName: "My Global Custom Field",
              hint: "This is my global custom field. Doesn't do anything special.",
            },
            "default value", // Default Value
          )
          // You can add more fields by chaining the field method.
          // For example:
          //  .field("anotherGlobalField", ...)
          .build();
```

If you've added your config schematics manual, you will also need to register the configurations in your plugin's `index.ts` file.

This is done by calling `context.withConfigSchematics(configSchematics)` and `context.withGlobalConfigSchematics(globalConfigSchematics)` in the `main` function of your plugin.

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

          // Register the configuration schematics.
          context.withConfigSchematics(configSchematics);
          // Register the global configuration schematics.
          context.withGlobalConfigSchematics(globalConfigSchematics);

          // ... other plugin setup code ...
        }
```
