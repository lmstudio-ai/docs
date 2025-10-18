---
title: "Introduction"
description: "Add custom configurations to LM Studio plugins using TypeScript"
index: 1
---

LM Studio plugins support custom configurations. That is, you can define a configuration schema and LM Studio will present a UI to the user so they can configure your plugin without having to edit any code.

There are two types of configurations:

- **Per-chat configuration**: tied to a specific chat. Different chats can have different configurations. Most configurations that affects the behavior of the plugin should be of this type.
- **Global configuration**: apply to _all_ chats and are shared across the application. This is useful for global settings such as API keys.

## Types of Configurations

You can define configurations in TypeScript using the `createConfigSchematics` function from the `@lmstudio/sdk` package. This function allows you to define fields with various types and options.

Supported types include:

- `string`: A text input field.
- `numeric`: A number input field with optional validation and slider UI.
- `boolean`: A checkbox or toggle input field.
- `stringArray`: An array of string values with configurable constraints.
- `select`: A dropdown selection field with predefined options.

See the [Defining New Fields](./custom-configuration/defining-new-fields) section for more details on how to define these fields.

## Examples

The following are some plugins that make use of custom configurations

- [lmstudio/wikipedia](https://lmstudio.ai/lmstudio/wikipedia)

  Gives the LLM tools to search and read Wikipedia articles.

- [lmstudio/openai-compat-endpoint](https://lmstudio.ai/lmstudio/openai-compat-endpoint)

  Use any OpenAI-compatible API in LM Studio.
