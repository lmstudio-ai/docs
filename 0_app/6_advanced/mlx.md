---
title: What is MLX
description: Learn about the MLX inference engine in LM Studio
index: 3
---

## What is MLX

[MLX](https://github.com/ml-explore/mlx) is a machine learning framework and library developed by Apple to optimize running ML workloads on Apple Silicon. [mlx-lm](https://github.com/ml-explore/mlx-lm/tree/main) and [mlx-vlm](https://github.com/Blaizzy/mlx-vlm) are packages built on top of the MLX framework that focuses specifically on performing inference with LLMs or VLMs, respectively. These packages maximize the speed and efficiency of running LLMs on Apple Silicon.

LM Studio integrates both mlx-lm and mlx-vlm into its MLX engine. Because MLX is built by Apple for Apple hardware, it is a Mac-only engine and is not available on other platforms.

## MLX and unified memory

Unlike traditional systems where CPU and GPU maintain separate memory pools, Apple Silicon uses a unified memory architecture. Both GGUF and MLX take advantage of this hardware design, but MLX is built specifically for Apple Silicon and typically results in better performance (faster inference speeds) on Macs compared to GGUF.

## MLX in LM Studio

If you’re using LM Studio on a Mac, you will see MLX as an available engine under Runtime Settings (⌘⇧R). 

<img src="/assets/docs/settings-runtime-mlx.png" data-caption="MLX engine" />

When browsing models in LM Studio, you may see entries like `lmstudio-community/Qwen3-Coder-Next-MLX-4bit`. The LM Studio team maintains our own MLX conversions for popular open source models on Hugging Face at [lmstudio-community](https://huggingface.co/lmstudio-community).

### Download an MLX model

**From the GUI**

In the app, head to the Model Search tab and filter by MLX to see only models in that format.

<img src="/assets/docs/modelsearch-mlx.png" data-caption="Filter by MLX in model search" />

**Using the CLI**

From the terminal, use `lms get` and include the `--mlx` flag to only show MLX models:

```bash
lms get --mlx
```
Read more about `lms get` [here](https://lmstudio.ai/docs/cli/local-models/get).

## Choosing between MLX and llama.cpp

Note that the MLX engine only supports models in MLX format, and the llama.cpp engine only supports models in GGUF format. 

If you're on a Mac device, our Staff Picks will recommend the MLX model if it’s available as an option, and otherwise exclude the option if it is not recommended over GGUF.

## Converting models to MLX format

Many popular models already have MLX versions available. Before converting manually, check out [lmstudio-community](https://huggingface.co/lmstudio-community) or [mlx-community](https://huggingface.co/mlx-community) on HuggingFace to see if the model you want is available in MLX format. 

Models stored locally in other formats can be converted to MLX format to use with the MLX engine. See our guide on [converting models to MLX format](../modelyaml/convert-to-mlx).
