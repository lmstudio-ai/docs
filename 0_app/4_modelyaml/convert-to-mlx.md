---
title: Convert Models to MLX
description: Convert models to MLX format for use with the MLX runtime in LM Studio
index: 6
---

## Convert a model to MLX format
Convert models to MLX to use with LM Studio’s MLX runtime backend. 

LM Studio’s MLX capability integrates two different implementations, **mlx-lm** and **mlx-vlm**. The former should be used for text-only models while the latter should be used for vision models.


## Prerequisites

You’ll need a Mac with Apple Silicon (M-series)

### Install the packages

**Text-only models**

```bash
pip install mlx-lm
```

**Vision models**

```bash
pip install mlx-vlm
pip3 install torch torchvision
```

### Run the conversion scripts
Use the conversion package that corresponds to your model type below.


## Convert a Hugging Face model to MLX

### Text-only models

```bash
python -m mlx_lm convert 
  --hf-path \
  --mlx-path /path/to/output/mlx-model
```

Example command to convert Qwen3-0.6B:

```bash
python -m mlx_lm convert --hf-path Qwen/Qwen3-0.6B
```

### Vision models 

```bash
mlx_vlm.convert
  --hf-path \ 
  --mlx-path /path/to/output/mlx-model
```

Example command to convert Qwen2.5-VL-3B-Instruct:

```bash
mlx_vlm.convert --hf-path Qwen/Qwen2.5-VL-3B-Instruct
```

Note the following flags to include for either conversion tool:
`--hf-path` is the path to the Hugging Face model 
`--mlx-path` is where you’d like the converted model to be saved

To directly place the converted model in LM Studio’s model directory, we recommend setting `--mlx-path` to the following:

```bash
~/.lmstudio/models/publisher/modelName
```

For the Qwen2.5-VL-3B-Instruct model above, an example command would look like:

```bash
mlx_vlm.convert --hf-path Qwen/Qwen2.5-VL-3B-Instruct –-mlx-path ~/.lmstudio/models/publisher/Qwen2.5-VL-3B-Instruct-MLX
```

This way, you’ll see the model in LM Studio as soon as the conversion is complete – no import step needed.

Use the `--help` flag on either command (e.g., `python -m mlx_vlm.convert --help`) to view advanced conversion options such as quantization.

## Use the converted model in LM Studio

**Note**: Skip this step if you placed the conversion output directly in LM Studio’s model directory.
 
If you do not include the --mlx-path flag in your command, the tool automatically creates a folder called mlx_model in the folder you were currently in. In this case, you’ll need to manually import the converted MLX model to LM Studio by placing it in LM Studio’s expected models directory structure. By default, LM Studio stores models in `~/.lmstudio/models/`.


See our [MLX overview](../runtimes/mlx) for more information about using MLX models in LM Studio.
