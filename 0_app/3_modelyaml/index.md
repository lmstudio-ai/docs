---
title: "Introduction to `model.yaml`"
description: Describe models with the cross-platform `model.yaml` specification.
index: 5
socialCard: 
  url: https://files.lmstudio.ai/modelyaml-card.jpg
  alt: "model.yaml logo"
---

`Draft`

[`model.yaml`](https://modelyaml.org) describes a model and all of its variants in a single portable file. Models in LM Studio's [model catalog](https://lmstudio.ai/models) are all implemented using model.yaml.

This allows abstracting away the underlying format (GGUF, MLX, etc) and presenting a single entry point for a given model. Furthermore, the model.yaml file supports baking in additional metadata, load and inference options, and even custom logic (e.g. enable/disable thinking).

**You can clone existing model.yaml files on the LM Studio Hub and even [publish your own](./modelyaml/publish)!**

## Core fields

### `model`

The canonical identifier in the form `publisher/model`.

```yaml
model: qwen/qwen3-8b
```

### `base`

Points to the "concrete" model files or other virtual models. Each entry uses a unique `key` and one or more `sources` from which the file can be fetched.

The snippet below demonstrates a case where the model (`qwen/qwen3-8b`) can resolve to one of 3 different concrete models.

```yaml
model: qwen/qwen3-8b
base:
  - key: lmstudio-community/qwen3-8b-gguf
    sources:
      - type: huggingface
        user: lmstudio-community
        repo: Qwen3-8B-GGUF
  - key: lmstudio-community/qwen3-8b-mlx-4bit
    sources:
      - type: huggingface
        user: lmstudio-community
        repo: Qwen3-8B-MLX-4bit
  - key: lmstudio-community/qwen3-8b-mlx-8bit
    sources:
      - type: huggingface
        user: lmstudio-community
        repo: Qwen3-8B-MLX-8bit
```

Concrete model files refer to the actual weights.

### `metadataOverrides`

Overrides the base model's metadata. This is useful for presentation purposes, for example in LM Studio's model catalog or in app model search. It is not used for any functional changes to the model.

```yaml
metadataOverrides:
  domain: llm
  architectures:
    - qwen3
  compatibilityTypes:
    - gguf
    - safetensors
  paramsStrings:
    - 8B
  minMemoryUsageBytes: 4600000000
  contextLengths:
    - 40960
  vision: false
  reasoning: true
  trainedForToolUse: true
```

### `config`

Use this to "bake in" default runtime settings (such as sampling parameters) and even load time options.
This works similarly to [Per Model Defaults](/docs/app/advanced/per-model).

- `operation:` inference time parameters
- `load:` load time parameters

```yaml
config:
  operation:
    fields:
      - key: llm.prediction.topKSampling
        value: 20
      - key: llm.prediction.temperature
        value: 0.7
  load:
    fields:
      - key: llm.load.contextLength
        value: 42690
```

### `customFields`

Define model-specific custom fields.

```yaml
customFields:
  - key: enableThinking
    displayName: Enable Thinking
    description: Controls whether the model will think before replying
    type: boolean
    defaultValue: true
    effects:
      - type: setJinjaVariable
        variable: enable_thinking
```

In order for the above example to work, the jinja template needs to have a variable named `enable_thinking`.

## Complete example

Taken from https://lmstudio.ai/models/qwen/qwen3-8b

```yaml
# model.yaml is an open standard for defining cross-platform, composable AI models
# Learn more at https://modelyaml.org
model: qwen/qwen3-8b
base:
  - key: lmstudio-community/qwen3-8b-gguf
    sources:
      - type: huggingface
        user: lmstudio-community
        repo: Qwen3-8B-GGUF
  - key: lmstudio-community/qwen3-8b-mlx-4bit
    sources:
      - type: huggingface
        user: lmstudio-community
        repo: Qwen3-8B-MLX-4bit
  - key: lmstudio-community/qwen3-8b-mlx-8bit
    sources:
      - type: huggingface
        user: lmstudio-community
        repo: Qwen3-8B-MLX-8bit
metadataOverrides:
  domain: llm
  architectures:
    - qwen3
  compatibilityTypes:
    - gguf
    - safetensors
  paramsStrings:
    - 8B
  minMemoryUsageBytes: 4600000000
  contextLengths:
    - 40960
  vision: false
  reasoning: true
  trainedForToolUse: true
config:
  operation:
    fields:
      - key: llm.prediction.topKSampling
        value: 20
      - key: llm.prediction.minPSampling
        value:
          checked: true
          value: 0
customFields:
  - key: enableThinking
    displayName: Enable Thinking
    description: Controls whether the model will think before replying
    type: boolean
    defaultValue: true
    effects:
      - type: setJinjaVariable
        variable: enable_thinking
```

The [GitHub specification](https://github.com/modelyaml/modelyaml) contains further details and the latest schema.
