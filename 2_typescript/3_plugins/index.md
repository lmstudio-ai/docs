---
title: "Introduction to Plugins"
description: "A brief introduction to making plugins for LM Studio using TypeScript."
index: 1
---

Plugins extend LM Studio's functionality by providing "hook functions" that execute at specific points during operation.

Plugins are currently written in JavaScript/TypeScript and run on Node.js v20.18.0. Python support is in development.

## Getting Started

LM Studio includes Node.js, so no separate installation is required.

### Create a new plugin

To create a new plugin, navigate to LM Studio... [TO BE CONTINUED]

### Run a plugin in development mode

Once you've created a plugin, run this command in the plugin directory to start development mode:

```bash
lms dev
```

Your plugin will appear in LM Studio's plugin list. Development mode automatically rebuilds and reloads your plugin when you make code changes.

You only need `lms dev` during development. When the plugin is installed, LM Studio automatically runs them as needed. Learn more about distributing and installing plugins in the [Sharing Plugins](./plugins/publish-plugins) section.

## Next Steps

- [Tools Providers](./plugins/tools-provider)

  Give models extra capabilities by creating tools they can use during generation, like accessing external APIs or performing calculations.

- [Prompt Preprocessors](./plugins/prompt-preprocessor)

  Modify user input before it reaches the model - handle file uploads, inject context, or transform queries.

- [Generators](./plugins/generator)

  Create custom text generation sources that replace the local model, perfect for online model adapters.

- [Custom Configurations](./plugins/custom-configuration)

  Add configuration UIs so users can customize your plugin's behavior.

- [Third-Party Dependencies](./plugins/dependencies)

  Use npm packages to leverage existing libraries in your plugins.

- [Sharing Plugins](./plugins/publish-plugins)

  Package and share your plugins with the community.
