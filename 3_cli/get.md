---
title: "`lms get` Reference"
sidebar_title: "`lms get`"
description: Search and download models from the command line.
index: 4
---

The `lms get` command allows you to search and download models from online repositories. If no model is specified, it shows staff-picked recommendations.

Models you download via `lms get` will be stored in your LM Studio model directory. 

### Parameters
```lms_params
- name: "[search term]"
  type: "string"
  optional: true
  description: "The model to download. For specific quantizations, append '@' (e.g., 'llama-3.1-8b@q4_k_m')"
- name: "--mlx"
  type: "flag"
  optional: true
  description: "Include MLX models in search results"
- name: "--gguf"
  type: "flag"
  optional: true
  description: "Include GGUF models in search results"
- name: "--limit"
  type: "number"
  optional: true
  description: "Limit the number of model options shown"
- name: "--always-show-all-results"
  type: "flag"
  optional: true
  description: "Always show search results, even with exact matches"
- name: "--always-show-download-options"
  type: "flag"
  optional: true
  description: "Always show quantization options, even with exact matches"
- name: "--yes"
  type: "flag"
  optional: true
  description: "Skip all confirmations. Uses first match and recommended quantization"
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

### Automated downloads

For scripting, skip all prompts:

```shell
lms get llama-3.1-8b --yes
```

This will automatically select the first matching model and recommended quantization for your hardware.