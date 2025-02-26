---
title: "`lmstudio-python` (Python SDK)"
sidebar_title: "Introduction"
description: "Getting started with LM Studio's Typescript / JavaScript SDK"
---

`lmstudio-python` provides you a set APIs to interact with LLMs, embeddings models, and agentic flows.

## Installing the SDK

`lmstudio-python` is available as an pypi package. You can install it using pip.

```lms_code_snippet
  variants:
    pip:
      language: bash
      code: |
        pip install lmstudio
```

For the source code and open source contribution, visit [lmstudio-python](https://github.com/lmstudio-ai/lmstudio-python) on GitHub.

## Features

- Use LLMs to [respond in chats](./python/llm-prediction/chat-completion) or predict [text completions](./python/llm-prediction/completion)
- Define functions as tools, and turn LLMs into [autonomous agents](./python/agent) that run completely locally
- [Load](./python/manage-models/loading), [configure](./python/llm-prediction/parameters), and [unload](./python/manage-models/loading) models from memory
- Generate embeddings for text, and more!

## Quick Example: Chat with a Llama Model

```lms_code_snippet
  title: "example.py"
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";
        const client = new LMStudioClient();

        const model = await client.llm.model("llama-3.2-1b-instruct");
        const result = await model.respond("What is the meaning of life?");
        
        console.info(result.content);
```

### Getting Local Models

The above code requires the Llama 3.2 1B. If you don't have the model, run the following command in the terminal to download it.

```bash
lms get llama-3.2-1b-instruct
```

Read more about `lms get` in LM Studio's CLI [here](./cli/get).
