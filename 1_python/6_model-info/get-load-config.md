---
title: Get Load Config
description: Get the load configuration of the model
---

_Required Python SDK version_: **1.2.0**

LM Studio allows you to configure certain parameters when loading a model
[through the server UI](/docs/advanced/per-model) or [through the API](/docs/api/sdk/load-model).

You can retrieve the config with which a given model was loaded using the SDK.

In the below examples, the LLM reference can be replaced with an
embedding model reference without requiring any other changes.

:::tip[Pro Tip]
Context length is a special case that [has its own method](/docs/api/sdk/get-context-length).
:::

```python tab="Python (convenience API)"
import lmstudio as lms

model = lms.llm()

print(model.get_load_config())
```

```python tab="Python (scoped resource API)"
import lmstudio as lms

with lms.Client() as client:
    model = client.llm.model()

    print(model.get_load_config())
```

```python tab="Python (asynchronous API)"
# Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
# Requires Python SDK version 1.5.0 or later
import lmstudio as lms

async with lms.Client() as client:
    model = await client.llm.model()

    print(await model.get_load_config())
```
