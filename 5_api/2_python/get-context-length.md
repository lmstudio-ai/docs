---
title: Get Context Length
description: Get the context length of the model
---

## Overview

Because a model cannot respond to prompts longer than its context length, it can be useful
to know what the context length of your model is.

### Usage

You can obtain the context length of a loaded LLM or embedding model using the SDK
(in the below examples, `llm` can instead be replaced with an embedding model handle).

```lms_protip
To check whether a conversation is over the context limit for a model,
use this in conjunction with [tokenization](/docs/sdk/python/tokenization)
(see that page for details).
```

```lms_protip
The context length for a loaded model can be reconfigured without
invalidating existing handles, so care needs to be taken with caching
the context length locally in client applications.
```

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()

        context_length = llm.get_context_length()

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()

            context_length = llm.get_context_length()
```
