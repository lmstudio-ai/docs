---
title: Load and Access Models
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

### Load a new instance of a model

Calling `model()` will not load a new instance (copy) of a model if one already exists.
If you intentionally want to have multiple instances of the same model alive
at the same time, the SDK allows you to do so. Again, you'll need the model key,
but this time you can specify a custom _instance identifier_ to distinguish the
instance you're loading from the others.

```lms_protip
If you provide an instance identifier that already exists, the server will throw an error.
So if you don't really care, it's safer to leave out the identifier, in which case
the server will generate one for you that the SDK will use in the returned model handle.
You can always check in the server tab, too!
```

To access this feature, it is necessary to use the explicit client interface.

```lms_code_snippet
  title: Loading two instances of a model
  variants:
    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llama = client.llm.load_new_instance("llama-3.2-1b-instruct")
            another_llama = client.llm.load_new_instance("llama-3.2-1b-instruct", "second-llama")
```

### Unload a model

Once you no longer need a model, you can unload it by simply calling `unload()` on its handle.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()
        llm.unload()

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()
            llm.unload()
```

When using the explicit client interface, models can also be unloaded based on their
identifier name, without requiring a valid model handle:

```lms_code_snippet
  title: Unloading a model without a model handle
  variants:
    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            client.llm.unload("llama-3.2-1b-instruct")
            client.llm.unload("second-llama")
```


## Advanced Usage

### Time to live

You can specify a _time to live_ for a model you load, which is the idle time (in seconds)
after the last request until the model unloads. See [the page on TTL](/docs/api/ttl-and-auto-evict) for more on this.

```lms_protip
If you specify a TTL to `model()`, it will only apply if `model()` loads
a new instance, and will _not_ retroactively change the TTL of an existing instance.
```

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llama = lm.llm("llama-3.2-1b-instruct", ttl=3600)

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llama = client.llm.model("llama-3.2-1b-instruct", ttl=3600)
            another_llama = client.llm.load_new_instance("llama-3.2-1b-instruct", ttl=7200)
```

[//] # (TODO?: Cover the JIT implications of setting a TTL, and the default TTL variations)

### Progress callbacks

Loading a model requires transferring all the weights from disk to RAM/VRAM,
which can take a long time depending on your disk read speed and the size of the model.

In order to request status updates during this stage of the process, `load_new_instance()`
and `model()` both accept optional `on_progress` callback parameters. These callback
methods accept a single `float` callback value which progresses from `0.0` through to
`1.0` as the LM Studio instance provides updates on the model loading progress.

To access this feature, it is necessary to use the explicit client interface.

```lms_code_snippet
  title: Requesting progress updates when loading a model
  variants:
    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llama = client.llm.load_new_instance(
                "llama-3.2-1b-instruct",
                on_progress: lambda progress: print(f"{progress*100}% loaded"),
            )
```

### Load config

You can also specify the same load configuration options as you could in the
in-app loading dropdown. Please consult your specific SDK to see exact syntax.

The same model load configuration options that may be specified via the LM Studio
in-app chat window sidebar may be specified via the SDK using the `config`
keyword-only parameter on the model loading methods.

Note that the `model()` method (and hence the `llm()` and `embedding_model()`)
may not actually load a new instance of the model, in which case the given
config may not be applied. If it is essential that the configuration be
applied as specified, then `load_new_instance()` will be a more reliable
option.

If using a type hinting aware Python editor, config dictionary keys are type
hinted appropriately, so the IDE will pick up spelling and data type errors.
Alternatively, the `lmstudio.LlmPredictionConfig` type may be used explicitly
when defining the configuration (although this approach is typically more
verbose than using a dictionary based configuration).
