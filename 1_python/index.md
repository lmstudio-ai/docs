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

        model = lms.llm("qwen/qwen3-4b-2507")
        result = model.respond("What is the meaning of life?")

        print(result)

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms

        with lms.Client() as client:
            model = client.llm.model("qwen/qwen3-4b-2507")
            result = model.respond("What is the meaning of life?")

            print(result)

    "Python (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        import lmstudio as lms

        async with lms.AsyncClient() as client:
            model = await client.llm.model("qwen/qwen3-4b-2507")
            result = await model.respond("What is the meaning of life?")

            print(result)
```

### Getting Local Models

The above code requires the [qwen3-4b-2507](https://lmstudio.ai/models/qwen/qwen3-4b-2507) model.
If you don't have the model, run the following command in the terminal to download it.

```bash
lms get qwen/qwen3-4b-2507
```

Read more about `lms get` in LM Studio's CLI [here](./cli/get).

# Interactive Convenience, Deterministic Resource Management, or Structured Concurrency?

As shown in the example above, there are three distinct approaches for working
with the LM Studio Python SDK.

The first is the interactive convenience API (listed as "Python (convenience API)"
in examples), which focuses on the use of a default LM Studio client instance for
convenient interactions at a synchronous Python prompt, or when using Jupyter notebooks.

The second is a synchronous scoped resource API (listed as "Python (scoped resource API)"
in examples), which uses context managers to ensure that allocated resources
(such as network connections) are released deterministically, rather than
potentially remaining open until the entire process is terminated.

The last is an asynchronous structured concurrency API (listed as "Python (asynchronous API)" in
examples), which is designed for use in asynchronous programs that follow the design principles of
["structured concurrency"](https://vorpus.org/blog/notes-on-structured-concurrency-or-go-statement-considered-harmful/)
in order to ensure the background tasks handling the SDK's connections to the API server host
are managed correctly. Asynchronous applications which do not adhere to those design principles
will need to rely on threaded access to the synchronous scoped resource API rather than attempting
to use the SDK's native asynchronous API. Python SDK version 1.5.0 is the first version to fully
support the asynchronous API.

Some examples are common between the interactive convenience API and the synchronous scoped
resource API. These examples are listed as "Python (synchronous API)".

## Timeouts in the synchronous API

_Required Python SDK version_: **1.5.0**

Starting in Python SDK version 1.5.0, the synchronous API defaults to timing out after 60 seconds
with no activity when waiting for a response or streaming event notification from the API server.

The number of seconds to wait for responses and event notifications can be adjusted using the
`lmstudio.set_sync_api_timeout()` function. Setting the timeout to `None` disables the timeout
entirely (restoring the behaviour of previous SDK versions).

The current synchronous API timeout can be queried using the `lmstudio.get_sync_api_timeout()`
function.

## Timeouts in the asynchronous API

_Required Python SDK version_: **1.5.0**

As asynchronous coroutines support cancellation, there is no specific timeout support implemented
in the asynchronous API. Instead, general purpose async timeout mechanisms, such as
[`asyncio.wait_for()`](https://docs.python.org/3/library/asyncio-task.html#asyncio.wait_for) or
[`anyio.move_on_after()`](https://anyio.readthedocs.io/en/stable/cancellation.html#timeouts),
should be used.
