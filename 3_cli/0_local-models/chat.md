---
title: "`lms chat`"
sidebar_title: "`lms chat`"
description: Start a chat session with a local model from the command line.
index: 1
---

Use `lms chat` to talk to a local model directly in the terminal. This is handy for quick experiments or scripting.

### Flags 
```lms_params
- name: "[model]"
  type: "string"
  optional: true
  description: "Identifier of the model to use. If omitted, you will be prompted to pick one."
- name: "-p, --prompt"
  type: "string"
  optional: true
  description: "Send a one-off prompt and print the response to stdout before exiting"
- name: "-s, --system-prompt"
  type: "string"
  optional: true
  description: "Custom system prompt for the chat"
- name: "--stats"
  type: "flag"
  optional: true
  description: "Show detailed prediction statistics after each response"
- name: "--ttl"
  type: "number"
  optional: true
  description: "Seconds to keep the model loaded after the chat ends (default: 3600)"
```

### Start an interactive chat

```shell
lms chat
```

You will be prompted to pick a model if one is not provided.

### Chat with a specific model

```shell
lms chat my-model
```

### Send a single prompt and exit

Use `-p` to print the response to stdout and exit instead of staying interactive:

```shell
lms chat my-model -p "Summarize this release note"
```

### Set a system prompt

```shell
lms chat my-model -s "You are a terse assistant. Reply in two sentences."
```

### Keep the model loaded after chatting

```shell
lms chat my-model --ttl 600
```

### Pipe input from another command

`lms chat` reads from stdin, so you can pipe content directly into a prompt:

```shell
cat my_file.txt | lms chat -p "Summarize this, please"
```
