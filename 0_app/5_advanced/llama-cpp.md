---
title: What is llama.cpp
description: Learn about the llama.cpp inference engine in LM Studio
index: 2
---

## What is llama.cpp

If you’ve tinkered with open source models, you’ve likely heard of [llama.cpp](https://github.com/ggml-org/llama.cpp). llama.cpp is an open-source inference engine written in C++, developed by Georgi Gerganov in 2023. The goal of this project is to make LLM inference accessible across a wide range of hardware, with minimal setup and without compromising on performance. LM Studio integrates llama.cpp under the hood as one of our primary engines. 


### Relevant Terminology

- **GGUF**: GGUF (GPT-Generated Unified Format) is a file format for packaging a model with its weights and all the metadata needed to run them into a single, portable file. Any model in GGUF format can be loaded and run with the llama.cpp engine.
- **Quantization**: Today, most foundation open source models are still very large in size — a 7B parameter model at full float32 precision is around 28GB. In order to run these models on consumer hardware with limited memory, llama.cpp leverages quantization – a method to reduce model size with minimal quality loss – and stores quantized versions in the GGUF format. 


## llama.cpp in LM Studio

In the LM Studio app, open Runtime settings (⌘⇧R) to see llama.cpp as the runtime selection for GGUF.

<img src="/assets/docs/settings-runtime-llamacpp.png" data-caption="llama.cpp engine" />

 When downloading models in LM Studio, you may see <Model-Name>-Q4_K_M.gguf in the model card. Q4_K_M.gguf indicates a Q4 quantized version of the model stored in GGUF format.

## Download a GGUF model 

**From the GUI**

In the app, head to the Model Search tab and filter by GGUF to see only models in that format.

<img src="/assets/docs/modelsearch-gguf.png" data-caption="Filter by GGUF in model search" />

**Using the CLI**

From the terminal, use `lms get` and include the `--gguf` flag to only show models in the GGUF format:

```bash
lms get --gguf
```

## Converting models to GGUF format

Many popular models already have GGUF versions available. Before converting manually, check if the model is available in GGUF format in [lmstudio-community](https://huggingface.co/lmstudio-community) or by using the `hf.co/models?library=gguf` tag on HuggingFace.

Models stored locally in other formats can be converted to GGUF to run with llama.cpp. Non-GGUF models can be converted using the Python scripts in the [llama.cpp repository](https://github.com/ggml-org/llama.cpp).

