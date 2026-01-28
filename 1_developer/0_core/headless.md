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

<img src="/assets/docs/headless-settings.webp" style="" data-caption="Enable the LLM server to start on machine login" />

When this setting is enabled, exiting the app will minimize it to the system tray, and the LLM server will continue to run in the background.

## Just-In-Time (JIT) model loading for REST endpoints

Useful when utilizing LM Studio as an LLM service with other frontends or applications.

<img src="/assets/docs/jit-loading.webp" style="" data-caption="Load models on demand" />

#### When JIT loading is ON:

- Calls to OpenAI-compatible `/v1/models` will return all downloaded models, not only the ones loaded into memory
- Calls to inference endpoints will load the model into memory if it's not already loaded

#### When JIT loading is OFF:

- Calls to OpenAI-compatible `/v1/models` will return only the models loaded into memory
- You have to first load the model into memory before being able to use it

#### What about auto unloading?

JIT loaded models will be auto-unloaded from memory by default after a set period of inactivity ([learn more](/docs/developer/core/ttl-and-auto-evict)).

## Auto Server Start

Your last server state will be saved and restored on app or service launch.

To achieve this programmatically, you can use the following command:

```bash
lms server start
```

### Community

Chat with other LM Studio developers, discuss LLMs, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).

Please report bugs and issues in the [lmstudio-bug-tracker](https://github.com/lmstudio-ai/lmstudio-bug-tracker/issues) GitHub repository.
