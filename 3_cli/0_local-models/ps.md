---
title: "`lms ps`"
sidebar_title: "`lms ps`"
description: Show information about currently loaded models from the command line.
index: 5
---

The `lms ps` command displays information about all models currently loaded in memory.

## List loaded models

Show all currently loaded models:

```shell
lms ps
```

Example output:
```
   LOADED MODELS

Identifier: unsloth/deepseek-r1-distill-qwen-1.5b
  • Type:  LLM
  • Path: unsloth/DeepSeek-R1-Distill-Qwen-1.5B-GGUF/DeepSeek-R1-Distill-Qwen-1.5B-Q4_K_M.gguf
  • Size: 1.12 GB
  • Architecture: Qwen2
```

### JSON output

Get the list in machine-readable format:
```shell
lms ps --json
```

## Operate on a remote LM Studio instance

`lms ps` supports the `--host` flag to connect to a remote LM Studio instance:

```shell
lms ps --host <host>
```

For this to work, the remote LM Studio instance must be running and accessible from your local machine, e.g. be accessible on the same subnet.
