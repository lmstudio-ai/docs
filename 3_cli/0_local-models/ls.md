---
title: "`lms ls`"
sidebar_title: "`lms ls`"
description: List all downloaded models in your LM Studio installation.
index: 4
---

The `lms ls` command displays a list of all models downloaded to your machine, including their size, architecture, and parameters.

### Flags 

```lms_params
- name: "--llm"
  type: "flag"
  optional: true
  description: "Show only LLMs. When not set, all models are shown"
- name: "--embedding"
  type: "flag"
  optional: true
  description: "Show only embedding models"
- name: "--json"
  type: "flag"
  optional: true
  description: "Output the list in JSON format"
- name: "--detailed"
  type: "flag"
  optional: true
  description: "Show detailed information about each model"
```

## List all models

Show all downloaded models:

```shell
lms ls
```

Example output:

```
You have 47 models, taking up 160.78 GB of disk space.

LLMs (Large Language Models)                       PARAMS      ARCHITECTURE           SIZE
lmstudio-community/meta-llama-3.1-8b-instruct          8B         Llama            4.92 GB
hugging-quants/llama-3.2-1b-instruct                   1B         Llama            1.32 GB
mistral-7b-instruct-v0.3                                         Mistral           4.08 GB
zeta                                                   7B         Qwen2            4.09 GB

... (abbreviated in this example) ...

Embedding Models                                   PARAMS      ARCHITECTURE           SIZE
text-embedding-nomic-embed-text-v1.5@q4_k_m                     Nomic BERT        84.11 MB
text-embedding-bge-small-en-v1.5                     33M           BERT           24.81 MB
```

### Filter by model type

List only LLM models:

```shell
lms ls --llm
```

List only embedding models:

```shell
lms ls --embedding
```

### Additional output formats

Get detailed information about models:

```shell
lms ls --detailed
```

Output in JSON format:

```shell
lms ls --json
```

## Operate on a remote LM Studio instance

`lms ls` supports the `--host` flag to connect to a remote LM Studio instance:

```shell
lms ls --host <host>
```

For this to work, the remote LM Studio instance must be running and accessible from your local machine, e.g. be accessible on the same subnet.
