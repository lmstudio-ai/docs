---
title: Import Models
description: Use model files you've downloaded outside of LM Studio
index: 6
---

You can use compatible models you've downloaded outside of LM Studio by placing them in the expected directory structure.

<hr>

### Use `lms import` (experimental)

To import a `GGUF` model you've downloaded outside of LM Studio, run the following command in your terminal:

```bash
lms import <path/to/model.gguf>
```

###### Follow the interactive prompt to complete the import process.

### LM Studio's expected models directory structure

<img src="/assets/docs/reveal-models-dir.png" style="width:80%" data-caption="Manage your models directory in the My Models tab">

LM Studio aims to preserves the directory structure of models downloaded from Hugging Face. The expected directory structure is as follows:

```xml
~/.lmstudio/models/
└── publisher/
    └── model/
        └── model-file.gguf
```

For example, if you have a model named `ocelot-v1` published by `infra-ai`, the structure would look like this:

```xml
~/.lmstudio/models/
└── infra-ai/
    └── ocelot-v1/
        └── ocelot-v1-instruct-q4_0.gguf
```

<hr>

### Community

Chat with other LM Studio users, discuss LLMs, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).
