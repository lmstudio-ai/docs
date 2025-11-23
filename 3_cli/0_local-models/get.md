---
title: "`lms get`"
sidebar_title: "`lms get`"
description: Search and download models from the command line.
index: 2
---

The `lms get` command allows you to search and download models from online repositories. If no model is specified, it shows staff-picked recommendations.

Models you download via `lms get` will be stored in your LM Studio model directory. 

### Flags 
```lms_params
- name: "[modelName]"
  type: "string"
  optional: true
  description: "The model to download. If omitted, staff picks are shown. For models with multiple quantizations, append '@' (e.g., 'llama-3.1-8b@q4_k_m')."
- name: "--mlx"
  type: "flag"
  optional: true
  description: "Include only MLX models in search results. If either '--mlx' or '--gguf' is set, only matching formats are shown; otherwise results match installed runtimes."
- name: "--gguf"
  type: "flag"
  optional: true
  description: "Include only GGUF models in search results. If either '--mlx' or '--gguf' is set, only matching formats are shown; otherwise results match installed runtimes."
- name: "-n, --limit"
  type: "number"
  optional: true
  description: "Limit the number of model options shown."
- name: "--always-show-all-results"
  type: "flag"
  optional: true
  description: "Always prompt you to choose from search results, even when there's an exact match."
- name: "-a, --always-show-download-options"
  type: "flag"
  optional: true
  description: "Always prompt you to choose a quantization, even when an exact match is auto-selected."
```

## Download a model

Download a model by name:

```shell
lms get llama-3.1-8b
```

### Specify quantization

Download a specific model quantization:

```shell
lms get llama-3.1-8b@q4_k_m
```

### Filter by format

Show only MLX or GGUF models:

```shell
lms get --mlx
lms get --gguf
```

### Control search results

Limit the number of results:

```shell
lms get --limit 5
```

Always show all options:

```shell
lms get --always-show-all-results
lms get --always-show-download-options
```
