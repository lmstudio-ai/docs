---
title: "`lmstudio-python` (Python SDK)"
sidebar_title: "Introduction"
description: "Getting started with LM Studio's Python SDK"
---

`lmstudio-python` provides you a set APIs to interact with LLMs, embeddings models, and agentic flows.

## Installing the SDK

`lmstudio-python` is available as a PyPI package. You can install it using pip.

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
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        model = lms.llm("llama-3.2-1b-instruct")
        result = model.respond("What is the meaning of life?")

        print(result)

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms

        with lms.Client() as client:
            model = client.llm.model("llama-3.2-1b-instruct")
            result = model.respond("What is the meaning of life?")

            print(result)
```

### Getting Local Models

The above code requires the Llama 3.2 1B model.
If you don't have the model, run the following command in the terminal to download it.

```bash
lms get llama-3.2-1b-instruct
```

Read more about `lms get` in LM Studio's CLI [here](./cli/get).

# Interactive Convenience or Deterministic Resource Management?

As shown in the example above, there are two distinct approaches for working
with the LM Studio Python SDK.

The first is the interactive convenience API (listed as "Python (convenience API)"
in examples), which focuses on the use of a default LM Studio client instance for
convenient interactions at a Python prompt, or when using Jupyter notebooks.

The second is a scoped resource API (listed as "Python (scoped resource API)"
in examples), which uses context managers to ensure that allocated resources
(such as network connections) are released deterministically, rather than
potentially remaining open until the entire process is terminated.
