---
title: "Configurations"
description: "Add custom configurations to LM Studio plugins using TypeScript"
index: 5
---

```lms_private_beta
Plugin support is currently in private beta. [Join the beta here](https://forms.gle/ZPfGLMvVC6DbSRQm9).
```

LM Studio plugins support custom configurations. That is, you can define a configuration schema and LM Studio will present a UI to the user so they can configure your plugin without having to edit any code.

There are two types of configurations:

- Per-chat configuration: These are configurations that are tied to a specific chat. Different chats can have different configurations. Most configurations that affects the behavior of the plugin should be of this type.
- Global configuration: These are configurations that apply to all chats and are shared across the application. This is useful for global settings such as API keys.

By default, the plugin scaffold will create a `config.ts` file in the `src` directory which will contain the schematics of the configurations. If the files does not exist, you can create it manually:

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

You will also need to register the configurations in your plugin's `index.ts` file:

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

## Accessing Configurations

You can access the configuration using the method `ctl.getPluginConfig(configSchematics)` and `ctl.getGlobalConfig(globalConfigSchematics)` respectively.

For example, here is how to access the config within the preprocessor:

```lms_code_snippet
  title: "src/preprocessor.ts"
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

## Defining New Fields

We support the following field types:

- `string`: A text input field.

  ```lms_code_snippet
    variants:
      TypeScript:
        language: typescript
        code: |
          // ... other fields ...
          .field(
            "stringField", // The key of the field.
            "string", // Type of the field.
            {
              displayName: "A string field",
              subtitle: "Subtitle", // Optional subtitle for the field. (Show below the field)
              hint: "Hint", // Optional hint for the field. (Show on hover)
              isParagraph: false, // Whether to show a large text input area for this field.
              isProtected: false, // Whether the value should be obscured in the UI (e.g., for passwords).
              placeholder: "Placeholder text", // Optional placeholder text for the field.
            },
            "default value", // Default Value
          )
          // ... other fields ...
  ```

- `numeric`: A number input field with optional validation and slider UI.

  ```lms_code_snippet
    variants:
      TypeScript:
        language: typescript
        code: |
          // ... other fields ...
          .field(
            "numberField", // The key of the field.
            "numeric", // Type of the field.
            {
              displayName: "A number field",
              subtitle: "Subtitle for", // Optional subtitle for the field. (Show below the field)
              hint: "Hint for number field", // Optional hint for the field. (Show on hover)
              int: false, // Whether the field should accept only integer values.
              min: 0, // Minimum value for the field.
              max: 100, // Maximum value for the field.
              slider: {
                // If present, configurations for the slider UI
                min: 0, // Minimum value for the slider.
                max: 100, // Maximum value for the slider.
                step: 1, // Step value for the slider.
              },
            },
            42, // Default Value
          )
          // ... other fields ...
  ```

- `boolean`: A checkbox or toggle input field.

  ```lms_code_snippet
    variants:
      TypeScript:
        language: typescript
        code: |
          // ... other fields ...
          .field(
            "booleanField", // The key of the field.
            "boolean", // Type of the field.
            {
              displayName: "A boolean field",
              subtitle: "Subtitle", // Optional subtitle for the field. (Show below the field)
              hint: "Hint", // Optional hint for the field. (Show on hover)
            },
            true, // Default Value
          )
          // ... other fields ...
  ```

- `stringArray`: An array of string values with configurable constraints.

  ```lms_code_snippet
    variants:
      TypeScript:
        language: typescript
        code: |
          // ... other fields ...
          .field(
            "stringArrayField",
            "stringArray",
            {
              displayName: "A string array field",
              subtitle: "Subtitle", // Optional subtitle for the field. (Show below the field)
              hint: "Hint", // Optional hint for the field. (Show on hover)
              allowEmptyStrings: true, // Whether to allow empty strings in the array.
              maxNumItems: 5, // Maximum number of items in the array.
            },
            ["default", "values"], // Default Value
          )
          // ... other fields ...
  ```

- `select`: A dropdown selection field with predefined options.

  ```lms_code_snippet
    variants:
      TypeScript:
        language: typescript
        code: |
          // ... other fields ...
          .field(
            "selectField",
            "select",
            {
              displayName: "A select field",
              options: [
                { value: "option1", displayName: "Option 1" },
                { value: "option2", displayName: "Option 2" },
                { value: "option3", displayName: "Option 3" },
              ],
              subtitle: "Subtitle", // Optional subtitle for the field. (Show below the field)
              hint: "Hint", // Optional hint for the field. (Show on hover)
            },
            "option1", // Default Value
          )
          // ... other fields ...
  ```
