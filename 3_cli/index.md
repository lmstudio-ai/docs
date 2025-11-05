---
title: "`lms` — LM Studio's CLI"
sidebar_title: "Introduction"
description: Get starting with the `lms` command line utility.
index: 1
---

LM Studio ships with `lms`, a command line tool for scripting and automating your local LLM workflows.

`lms` is **MIT Licensed** and is developed in this repository on GitHub: https://github.com/lmstudio-ai/lms

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

```shell
cmd /c %USERPROFILE%/.lmstudio/bin/lms.exe bootstrap
```

#### Verify the installation

Open a **new terminal window** and run `lms`.

This is the current output you will get:

```bash
$ lms

   __   __  ___  ______          ___        _______   ____
  / /  /  |/  / / __/ /___ _____/ (_)__    / ___/ /  /  _/
 / /__/ /|_/ / _\ \/ __/ // / _  / / _ \  / /__/ /___/ /
/____/_/  /_/ /___/\__/\_,_/\_,_/_/\___/  \___/____/___/

lms - LM Studio CLI - v0.0.47
GitHub: https://github.com/lmstudio-ai/lms

Usage
Usage: lms [options] [command]

LM Studio CLI

Options:
      -h, --help  display help for command

Manage Models:
      get         Searching and downloading a model from online.
      import      Import a model file into LM Studio
      ls          List all downloaded models

Use Models:
      chat        Open an interactive chat with the currently loaded model.
      load        Load a model
      ps          List all loaded models
      server      Commands for managing the local server
      unload      Unload a model

Develop & Publish Artifacts:
      clone       Clone an artifact from LM Studio Hub to a local folder.
      create      Create a new project with scaffolding
      dev         Starts the development server for the plugin in the current folder.
      login       Authenticate with LM Studio
      push        Uploads the plugin in the current folder to LM Studio Hub.

System Management:
      bootstrap   Bootstrap the CLI
      flags       Set or get experiment flags
      log         Log operations. Currently only supports streaming logs from LM Studio via `lms log
                  stream`
      runtime     Manage runtime engines
      status      Prints the status of LM Studio
      version     Prints the version of the CLI

Commands:
      help        display help for command
```

### Use `lms` to automate and debug your workflows

### Start and stop the local server

```bash
lms server start
lms server stop
```

### List the local models on the machine

```bash
lms ls
```

This will reflect the current LM Studio models directory, which you set in **📂 My Models** tab in the app.

### List the currently loaded models

```bash
lms ps
```

### Load a model (with options)

```bash
lms load [--gpu=max|auto|0.0-1.0] [--context-length=1-N]
```

`--gpu=1.0` means 'attempt to offload 100% of the computation to the GPU'.

- Optionally, assign an identifier to your local LLM:

```bash
lms load TheBloke/phi-2-GGUF --identifier="gpt-4-turbo"
```

This is useful if you want to keep the model identifier consistent.

### Unload models

```
lms unload [--all]
```
