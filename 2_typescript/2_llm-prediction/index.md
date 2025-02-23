---
title: Overview
description: Load, access, and unload models from the server
---

TODO: candidate for splitting into multiple articles

## Overview

You can load, access, and unload models using the LM Studio SDK just like you would
in the Server tab of the app itself. Loading models, or accessing a loaded model,
returns a _model handle_ that represents that model. You can use this handle to
do things like [respond to a conversation](/docs/sdk/python/chat-completion) or
[request text completion](/docs/sdk/python/completion).

### Access any model

If you only have one relevant model loaded, or you don't care exactly which
you get, you can simply call the `llm()` or `embedding_model()` convenience
functions to get a handle to an arbitrary loaded model of that type.
When using the explicit client API, the equivalent operations are
`client.llm.model()` and `client.embedding.model()`.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        # It's that simple!
        llm = lm.llm()

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            # It's that simple!
            llm = client.llm.model()
```

### Access a specific model

To create a handle for a specific model, you'll need that model's _model key_,
which you can find in the My Models tab of the LM Studio app:

[ TODO: image showing where to get a model key ]

Attempting to access a model by its key will first attempt to get a handle to an
already-loaded instance of that model, then fall back to loading a new one.
In any case, you can be certain your handle references the model the key points to.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llama = lm.llm("llama-3.2-1b-instruct")

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llama = client.llm.model("llama-3.2-1b-instruct")
```

Alternatively, [listing the loaded models](/docs/sdk/python/list-loaded) provides
a valid model handle for all currently loaded models, allowing the model of interest
to be selected locally.

[//] # (TODO?: Cover using client.{namespace}.get_model_info() with lmstudio.ModelQuery)
