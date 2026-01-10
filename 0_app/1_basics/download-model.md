---
title: Download an LLM
description: Discover and download supported LLMs in LM Studio
index: 3
---

LM Studio comes with a built-in model downloader that let's you download any supported model from [Hugging Face](https://huggingface.co).

<img src="/assets/docs/discover.png" style="width: 500px; margin-top:30px" data-caption="Download models from the Discover tab in LM Studio" />

<hr>

### Searching for models

You can search for models by keyword (e.g. `llama`, `gemma`, `lmstudio`), or by providing a specific `user/model` string. You can even insert full Hugging Face URLs into the search bar!

###### Pro tip: you can jump to the Discover tab from anywhere by pressing `⌘` + `2` on Mac, or `ctrl` + `2` on Windows / Linux.

### Which download option to choose?

You will often see several options for any given model named things like `Q3_K_S`, `Q_8` etc. These are all copies of the same model, provided in varying degrees of fidelity. The `Q` represents a technique called "Quantization", which roughly means compressing model files in size, while giving up some degree of quality.

Choose a 4-bit option or higher if your machine is capable enough for running it.

<img src="/assets/docs/search.webp" style="" data-caption="Hugging Face search results in LM Studio" />

<hr>

`Advanced`

### Changing the models directory

You can change the models directory by heading to My Models

<img src="/assets/docs/change-models-dir.png" style="width:80%" data-caption="Manage your models directory in the My Models tab">

<hr>

### Community

Chat with other LM Studio users, discuss LLMs, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).
