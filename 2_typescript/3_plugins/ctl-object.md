---
title: "The `ctl` Object"
description: "Learn more about the `ctl` object available in LM Studio plugin hooks"
index: 3
---

```lms_private_beta
Plugin support is currently in private beta. [Join the beta here](https://forms.gle/ZPfGLMvVC6DbSRQm9).
```

When you implement a plugin hook, such as a tools provider, a prompt preprocessor, or a generator, you will receive a `ctl` object as the first argument.

The `ctl` object provides various methods and properties that allow you to interact with the LM Studio environment, access configuration, manage tools, and handle abort signals.

The exact methods available are dependent on the type of plugin hook you are implementing. Below are some common methods and properties you might find useful:

## LM Studio API Access

Normally when using the LM Studio SDK, you will create, when make SDK, get Client from

Use `ctl.client` to interact with the LM Studio API:

```ts
// List loaded models
const models = await ctl.client.llm.listLoaded();
console.log(`Found ${models.length} loaded models`);
```

## Configuration

Get per-chat and application-wide configuration for your plugin:

```ts
const config = ctl.getPluginConfig(configSchematics);
const globalConfig = ctl.getGlobalPluginConfig(globalConfigSchematics);
const value = config.get("fieldKey");
```

For more details on creating and using configurations, see [Custom Configurations](./custom-configuration).

## File System

### `getWorkingDirectory()`

Returns the working directory path where your plugin should place any generated files.

## Cancellation Handling

Use `ctl.abortSignal` with async operations to support cancellation:

```ts
// Use with fetch requests
const response = await fetch("https://api.example.com/data", {
  signal: ctl.abortSignal,
});

// Or register a callback for cleanup
ctl.onAborted(() => {
  console.log("Operation cancelled - cleaning up...");
});
```
