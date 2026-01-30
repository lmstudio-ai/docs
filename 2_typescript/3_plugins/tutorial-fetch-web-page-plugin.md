---
title: "Tutorial: Make a Fetch Web Page Plugin"
sidebar_title: "Tutorial: Make a Fetch Web Page Plugin"
description: "Make a simple LM Studio plugin that allows the LLM to fetch and read web pages"
index: 7
---

```lms_private_beta
Plugin support is currently in private beta. [Join the beta here](https://forms.gle/ZPfGLMvVC6DbSRQm9).
```

In this tutorial, we will create a simple LM Studio plugin that allows the LLM to fetch and read web pages. This plugin will demonstrate how to use tools providers, handle aborts, and define custom configurations.

## Step 1: Create a New Plugin

1. Open LM Studio.
2. Press `⌘` `Shift` `R` on Mac or `Ctrl` `Shift` `R` on Windows/Linux to open the plugin creation wizard.
3. Select "Tools Provider" as the starting point.
4. Give the plugin a name, such as "fetch-web-page".
5. Click "Next" and select a directory to create the plugin in. LM Studio will create a new directory within the selected directory.
6. Open the newly created plugin directory in your code editor.

## Step 2: Install `npm` Package: `html-to-text`

In this plugin, we will use the `html-to-text` package to convert HTML content to plain text. To install this package, run the following command in your plugin directory:

```bash
cd /path/to/your/plugin
npm install html-to-text
npm install --save-dev @types/html-to-text
```

When your plugins is installed, we will automatically install the npm dependencies for the user. Your user do not need to have Node.js/npm installed.

Learn more about `npm` dependencies in the [Using `npm` Dependencies](./dependencies) section.

## Step 3: Define Configurations

For this plugin, we would like to allow the user to configure the User-Agent header used when fetching web pages. This is done by first defining the configuration schema.

Replace the code in `src/config.ts`:

```ts
import { createConfigSchematics } from "@lmstudio/sdk";

/**
 * This is the schematics of the per-chat configuration for your plugin. Configurations of this
 * type will be saved with each chat and can be different for each chat.
 */
export const configSchematics = createConfigSchematics().build();

/**
 * This is the schematics of the application-wide configuration for your plugin. Configurations of
 * this type will be saved globally and will be the same for all chats. This is useful for things
 * like global settings or API keys that should be consistent across all chats.
 */
export const globalConfigSchematics = createConfigSchematics()
  .field(
    "userAgent", // The key of the field.
    "string",
    {
      displayName: "User Agent",
      subtitle:
        "The User-Agent header to use when fetching web pages. This helps identify your requests to web servers.",
    },
    "Mozilla/5.0 (compatible; LMStudio-FetchWebsite/1.0)", // Default Value
  )
  .build();
```

## Step 4: Implement the Tools Provider

A tools provider is a function that when called, will return a list of tools that the LLM can use. The name and the description of the tool is provided to the LLM, and LLM will choose which tool to use based on the task at hand.

Replace the code in `src/toolsProvider.ts` with the following:

```ts
import { tool, Tool, ToolsProviderController } from "@lmstudio/sdk";
import { z } from "zod";
import { globalConfigSchematics } from "./config";
import { convert as convertHtmlToText } from "html-to-text";

// See details about defining tools in the documentation:
// https://lmstudio.ai/docs/typescript/agent/tools

export async function toolsProvider(ctl: ToolsProviderController) {
  // Access the global configuration for the plugin.
  const globalConfig = ctl.getGlobalPluginConfig(globalConfigSchematics);

  const tools: Tool[] = [];

  const fetchWebsiteTool = tool({
    name: "fetchWebsite",
    description: "Fetch the content of a web page given its URL.",
    parameters: { url: z.string() },
    implementation: async ({ url }) => {
      const response = await fetch(url, {
        headers: {
          "User-Agent": globalConfig.get("userAgent"),
        },
      });
      if (!response.ok) {
        return `Error: Unable to fetch the URL. Status code: ${response.status}`;
      }
      const rawHtml = await response.text();
      // Use the html-to-text package to convert HTML to plain text.
      return convertHtmlToText(rawHtml);
    },
  });
  tools.push(fetchWebsiteTool);

  return tools;
}
```

## Step 5: Run the Plugin in Development Mode

To use a plugin, you can either install the plugin, or run it in the "development mode". To run the plugin in development mode, run the following command in your plugin directory:

```bash
lms run dev
```

It will start the plugin development server and reload the plugin automatically when you make code changes.

Once the development server is running, you can enable the plugin in LM Studio. Load a model, and try to ask it to fetch a web page, for example:

```
What is the latest post on https://lmstudio.ai/blog?
```

The LLM model should automatically use the `fetchWebsite` tool to fetch the content of the web page and provide an answer based on the content.

If the model is having a hard time forming a correct tool call, you can try to use a model that has better tool calling capabilities, such as `gpt-oss-20b`. You can download the model using the command:

```bash
lms get openai/gpt-oss-20b
```

## Step 6: Distributing the Plugin

To share the plugin with other users, you can publish using the command:

```bash
lms push
```

Learn more about distributing and installing plugins in the [Sharing Plugins](./publish-plugins) section.
