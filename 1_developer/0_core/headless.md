---
title: "Run LM Studio as a service (headless)"
sidebar_title: "Headless Mode"
description: "GUI-less operation of LM Studio: run in the background, start on machine login, and load models on demand"
index: 2
---

LM Studio can be run as a service without the GUI. This is useful for running LM Studio on a server or in the background on your local machine. This works on Mac, Windows, and Linux machines with a graphical user interface.

## Run LM Studio as a service

Running LM Studio as a service consists of several new features intended to make it more efficient to use LM Studio as a developer tool.

1. The ability to run LM Studio without the GUI
2. The ability to start the LM Studio LLM server on machine login, headlessly
3. On-demand model loading

## Run the LLM service on machine login

To enable this, head to app settings (`Cmd` / `Ctrl` + `,`) and check the box to run the LLM server on login.

<img src="/assets/docs/headless-settings.png" style="" data-caption="Enable the LLM server to start on machine login" />

When this setting is enabled, exiting the app will minimize it to the system tray, and the LLM server will continue to run in the background.

## Just-In-Time (JIT) model loading for OpenAI endpoints

Useful when utilizing LM Studio as an LLM service with other frontends or applications.

<img src="/assets/docs/jit-loading.png" style="" data-caption="Load models on demand" />

#### When JIT loading is ON:

- Call to `/v1/models` will return all downloaded models, not only the ones loaded into memory
- Calls to inference endpoints will load the model into memory if it's not already loaded

#### When JIT loading is OFF:

- Call to `/v1/models` will return only the models loaded into memory
- You have to first load the model into memory before being able to use it

##### What about auto unloading?

As of LM Studio 0.3.5, auto unloading is not yet in place. Models that are loaded via JIT loading will remain in memory until you unload them.
We expect to implement more sophisticated memory management in the near future. Let us know if you have any feedback or suggestions.

## Auto Server Start

Your last server state will be saved and restored on app or service launch.

To achieve this programmatically, you can use the following command:

```bash
lms server start
```

```lms_protip
If you haven't already, bootstrap `lms` on your machine by following the instructions [here](/docs/cli).
```

### Community

Chat with other LM Studio developers, discuss LLMs, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).

Please report bugs and issues in the [lmstudio-bug-tracker](https://github.com/lmstudio-ai/lmstudio-bug-tracker/issues) GitHub repository.
