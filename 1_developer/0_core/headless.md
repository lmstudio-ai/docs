---
title: "Run LM Studio as a service (headless)"
sidebar_title: "`llmster` - Headless Mode"
description: "GUI-less operation of LM Studio: run in the background, start on machine login, and load models on demand"
index: 2
---

LM Studio can be run as a background service without the GUI. There are two ways to do this:

1. **llmster** (recommended) — a standalone daemon, no GUI required
2. **Desktop app in headless mode** — hide the UI and run the desktop app as a service

## Option 1: llmster (recommended)

llmster is the core of the LM Studio desktop app, packaged to be server-native, without reliance on the GUI. It can run on Linux boxes, cloud servers, GPU rigs, or your local machine without the GUI. See the [LM Studio 0.4.0 release post](/blog/0.4.0) for more details.

<img src="/assets/blog/0.4.0/llmster@2x.png" alt="llmster" style="" data-caption="" />


### Install llmster

**Linux / Mac**

```bash
curl -fsSL https://lmstudio.ai/install.sh | bash
```

**Windows**

```bash
irm https://lmstudio.ai/install.ps1 | iex
```

### Start llmster

```bash
lms daemon up
```


See the [daemon CLI docs](/docs/cli/daemon) for full reference.

For setting up llmster as a startup task on Linux, see [Linux Startup Task](/docs/developer/core/headless_llmster).

## Option 2: Desktop app in headless mode

This works on Mac, Windows, and Linux machines with a graphical user interface. It's useful if you already have the desktop app installed and want it to run as a background service.

### Run the LLM service on machine login

Head to app settings (`Cmd` / `Ctrl` + `,`) and check the box to run the LLM server on login.

<img src="/assets/docs/headless-settings.webp" style="" data-caption="Enable the LLM server to start on machine login" />

When this setting is enabled, exiting the app will minimize it to the system tray, and the LLM server will continue to run in the background.

### Auto Server Start

Your last server state will be saved and restored on app or service launch.

To achieve this programmatically:

```bash
lms server start
```

## Just-In-Time (JIT) model loading for REST endpoints

Applies to both options. Useful when using LM Studio as an LLM service with other frontends or applications.

<img src="/assets/docs/jit-loading.webp" style="" data-caption="Load models on demand" />

#### When JIT loading is ON:

- Calls to OpenAI-compatible `/v1/models` will return all downloaded models, not only the ones loaded into memory
- Calls to inference endpoints will load the model into memory if it's not already loaded

#### When JIT loading is OFF:

- Calls to OpenAI-compatible `/v1/models` will return only the models loaded into memory
- You have to first load the model into memory before being able to use it

#### What about auto unloading?

JIT loaded models will be auto-unloaded from memory by default after a set period of inactivity ([learn more](/docs/developer/core/ttl-and-auto-evict)).

### Community

Chat with other LM Studio developers, discuss LLMs, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).

Please report bugs and issues in the [lmstudio-bug-tracker](https://github.com/lmstudio-ai/lmstudio-bug-tracker/issues) GitHub repository.
