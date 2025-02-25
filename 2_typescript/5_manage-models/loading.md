---
title: "Manage Models in Memory"
sidebar_title: Load and Access Models
description: APIs to load, access, and unload models from memory
---

TODO: quick text about memory

## Get or Load a Model with `.model()`

For most task, use `.model()`.

Calling `model()` will...

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";
        const client = new LMStudioClient();

        const llama = await client.llm.model("llama-3.2-1b-instruct");
```

Learn more about the `.model()` method and the parameters it accepts in the [API Reference](../api-reference/model).

## Load a New Instance of a Model with `.load()`

Use `load()` to load a new instance of a model, even if one already exists. This allows you to have multiple instances of the same or different models loaded at the same time.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";
        const client = new LMStudioClient();

        const llama = await client.llm.load("llama-3.2-1b-instruct");
        const another_llama = await client.llm.load("llama-3.2-1b-instruct", "second-llama");
```

Learn more about the `.load()` method and the parameters it accepts in the [API Reference](../api-reference/load).


### Note about Instance Identifiers

If you provide an instance identifier that already exists, the server will throw an error.
So if you don't really care, it's safer to not provide an identifier, in which case
the server will generate one for you. You can always check in the server tab in LM Studio, too!


## Unload a Model from Memory with `.unload()`

Once you no longer need a model, you can unload it by simply calling `unload()` on its handle.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();

        const llm = await client.llm.model();
        await llm.unload()
```

## Set Custom Load Config Parameters

You can also specify the same load-time configuration options when loading a model, such as Context Length and GPU offload %. See [load-time configuration](../llm-prediction/parameters) for more.

## Set an Auto Unload Timer (TTL)

You can specify a _time to live_ for a model you load, which is the idle time (in seconds)
after the last request until the model unloads. See [the page on TTL](/docs/api/ttl-and-auto-evict) for more on this.

```lms_protip
If you specify a TTL to `model()`, it will only apply if `model()` loads
a new instance, and will _not_ retroactively change the TTL of an existing instance.
```

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();

        // TODO ttl in typescript?
        const llama = await client.llm.model("llama-3.2-1b-instruct");
        const another_llama = await client.llm.load("llama-3.2-1b-instruct");
```

