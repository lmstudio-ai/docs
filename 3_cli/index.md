---
title: "`lms` — LM Studio's CLI"
sidebar_title: "Introduction"
description: Get starting with the `lms` command line utility.
index: 1
---

## Install `lms`

`lms` ships with LM Studio, so you don't need to do any additional installation steps if you have LM Studio installed.

Just open a terminal window and run `lms`:

```shell
lms --help
```

## Open source

`lms` is **MIT Licensed** and is developed in this repository on GitHub: https://github.com/lmstudio-ai/lms

## Command quick links

| Command | Syntax | Docs |
| --- | --- | --- |
| Chat in the terminal | `lms chat` | [Guide](/docs/cli/local-models/chat) |
| Download models | `lms get` | [Guide](/docs/cli/local-models/get) |
| List your models | `lms ls` | [Guide](/docs/cli/local-models/ls) |
| See models loaded into memory | `lms ps` | [Guide](/docs/cli/local-models/ps) |
| Control the server | `lms server start` | [Guide](/docs/cli/serve/server-start) |
| Manage the inference runtime | `lms runtime` | [Guide](/docs/cli/runtime) |


### Verify the installation

```lms_info
👉 You need to run LM Studio _at least once_ before you can use `lms`.
```

Open a terminal window and run `lms`.

```lms_terminal
$ lms

lms is LM Studio's CLI utility for your models, server, and inference runtime. (v0.0.47)

Usage: lms [options] [command]

Local models
   chat               Start an interactive chat with a model
   get                Search and download models
   load               Load a model
   unload             Unload a model
   ls                 List the models available on disk
   ps                 List the models currently loaded in memory
   import             Import a model file into LM Studio

Serve
   server             Commands for managing the local server
   log                Log incoming and outgoing messages

Runtime
   runtime            Manage and update the inference runtime

Develop & Publish (Beta)
   clone              Clone an artifact from LM Studio Hub to a local folder
   push               Uploads the artifact in the current folder to LM Studio Hub
   dev                Starts a plugin dev server in the current folder
   login              Authenticate with LM Studio

Learn more:           https://lmstudio.ai/docs/developer
Join our Discord:     https://discord.gg/lmstudio
```

## Use `lms` to automate and debug your workflows

### Start and stop the local server

```bash
lms server start
lms server stop
```

Learn more about [`lms server`](/docs/cli/serve/server-start).

### List the local models on the machine

```bash
lms ls
```

Learn more about [`lms ls`](/docs/cli/local-models/ls).

This will reflect the current LM Studio models directory, which you set in **📂 My Models** tab in the app.

### List the currently loaded models

```bash
lms ps
```

Learn more about [`lms ps`](/docs/cli/local-models/ps).

### Load a model (with options)

```bash
lms load [--gpu=max|auto|0.0-1.0] [--context-length=1-N]
```

`--gpu=1.0` means 'attempt to offload 100% of the computation to the GPU'.

- Optionally, assign an identifier to your local LLM:

```bash
lms load openai/gpt-oss-20b --identifier="my-model-name"
```

This is useful if you want to keep the model identifier consistent.

### Unload a model
```
lms unload [--all]
```

Learn more about [`lms load and unload`](/docs/cli/local-models/load).
