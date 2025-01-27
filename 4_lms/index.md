---
title: "`lms` — LM Studio's CLI"
description: Get starting with the `lms` command line utility.
index: 1
---

LM Studio ships with `lms`, a command line tool for scripting and automating your local LLM workflows.

`lms` is MIT Licensed and it is developed in this repository on GitHub: https://github.com/lmstudio-ai/lms

<hr>

```lms_info
👉 You need to run LM Studio _at least once_ before you can use `lms`.
```

### Install `lms`

`lms` ships with LM Studio and can be found under `/bin` in the LM Studio's working directory.

Use the following commands to add `lms` to your system path.

#### Bootstrap `lms` on macOS or Linux

Run the following command in your terminal:

```bash
~/.lmstudio/bin/lms bootstrap
```

#### Bootstrap `lms` on Windows

Run the following command in **PowerShell**:

```ps1
cmd /c %USERPROFILE%/.lmstudio/bin/lms.exe bootstrap
```

#### Verify the installation

Open a **new terminal window** and run `lms`.

This is the current output you will get:

```bash
$ lms
lms - LM Studio CLI - v0.2.22
GitHub: https://github.com/lmstudio-ai/lmstudio-cli

Usage
lms <subcommand>

where <subcommand> can be one of:

- status - Prints the status of LM Studio
- server - Commands for managing the local server
- ls - List all downloaded models
- ps - List all loaded models
- load - Load a model
- unload - Unload a model
- create - Create a new project with scaffolding
- log - Log operations. Currently only supports streaming logs from LM Studio via `lms log stream`
- version - Prints the version of the CLI
- bootstrap - Bootstrap the CLI

For more help, try running `lms <subcommand> --help`
```

### Use `lms` to automate and debug your workflows

### Start and stop the local server

```
lms server start
lms server stop
```

### List the local models on the machine

```
lms ls
```

This will reflect the current LM Studio models directory, which you set in **📂 My Models** tab in the app.

### List the currently loaded models

```
lms ps
```

### Load a model (with options)

```
lms load [--gpu=max|auto|0.0-1.0] [--context-length=1-N]
```

`--gpu=1.0` means 'attempt to offload 100% of the computation to the GPU'.

- Optionally, assign an identifier to your local LLM:

```
lms load TheBloke/phi-2-GGUF --identifier="gpt-4-turbo"
```

This is useful if you want to keep the model identifier consistent.

### Unload models

```
lms unload [--all]
```
