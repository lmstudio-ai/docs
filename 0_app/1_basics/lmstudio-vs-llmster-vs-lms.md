---
title: LM Studio, llmster, and lms
description: Understand the differences between the LM Studio app, llmster, and lms
index: 5
---

## LM Studio app, llmster, and lms

The LM Studio app, llmster, and `lms` are three different tools offered by LM Studio to make use of local AI easy and accessible.

## LM Studio (the desktop app)

The LM Studio app is a user-friendly graphical interface containing the full capabilities of LM Studio.

### Notable capabilities:

- Search and download models from Hugging Face
- Chat with models through a built-in chat interface
- Upload and chat documents (RAG)
- Configure model settings, prompt templates, and presets
- Run a local server with through native REST APIs or OpenAI/Anthropic compatible endpoints
- Connect MCP servers and use them with local models

The desktop app is the easiest starting point if you're new to running models locally or prefer a graphical interface.

## llmster (the headless daemon)

llmster is LM Studio’s headless daemon – a standalone background service that can run without a GUI. This means you do not have to download the LM Studio app to use llmster via the terminal.

llmster becomes useful when you need to run LM Studio:
- On a Linux server or cloud instance
- On a GPU rig without a screen or display
- In a CI/CD pipeline
- As a background service that starts on machine boot
And more!

Because llmster runs independently of the desktop app, you can get the full model-serving capabilities of LM Studio in environments where installing or launching a GUI application isn't practical.

Learn more and install llmster [here](https://lmstudio.ai/docs/developer/core/headless)

## lms (the CLI)

`lms` is LM Studio's CLI (command-line interface). It lets you interact with both the LM Studio desktop app and llmster, and manage your models directly from a terminal. 

`lms` is included automatically upon downloading the app or llmster.

**Common commands:**

```bash
lms get <model>        # Download a model
lms load <model>       # Load a model into memory
lms ls                 # List models available on disk
lms server start       # Start the local HTTP server
lms chat               # Start an interactive chat session in the terminal
lms log stream         # Stream incoming and outgoing request logs
```

If LM Studio isn't already running when you run an `lms` command, it will start running automatically.

**Example commands to download and serve a model:**

```bash
lms get openai/gpt-oss-20b
lms load openai/gpt-oss-20b
lms server start
```

Once the server is running, it listens on http://localhost:1234. Point any SDK or compatible tool at our OpenAI or Anthropic-compatible endpoints to use your LM Studio models.

In short, `lms` is the command-line tool to talk to both, the desktop app or llmster.
