---
title: "Manage Models in Memory"
sidebar_title: Load and Access Models
description: APIs to load, access, and unload models from memory
---

AI models are huge. It can take a while to load them into memory. LM Studio's SDK allows you to precisely control this process.

**Most commonly:**

- Use `.model()` to get any currently loaded model
- Use `.model("model-key")` to use a specific model

**Advanced (manual model management):**

- Use `.load("model-key")` to load a new instance of a model
- Use `model.unload()` to unload a model from memory

## Get the Current Model with `.model()`

If you already have a model loaded in LM Studio (either via the GUI or `lms load`), you can use it by calling `.model()` without any arguments.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";
        const client = new LMStudioClient();

        const model = await client.llm.model();
```

## Get a Specific Model with `.model("model-key")`

If you want to use a specific model, you can provide the model key as an argument to `.model()`.

#### Get if Loaded, or Load if not

Calling `.model("model-key")` will load the model if it's not already loaded, or return the existing instance if it is.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";
        const client = new LMStudioClient();

        const model = await client.llm.model("qwen/qwen3-4b-2507");
```

<!-- Learn more about the `.model()` method and the parameters it accepts in the [API Reference](../api-reference/model). -->

## Load a New Instance of a Model with `.load()`

Use `load()` to load a new instance of a model, even if one already exists. This allows you to have multiple instances of the same or different models loaded at the same time.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";
        const client = new LMStudioClient();

        const llama = await client.llm.load("qwen/qwen3-4b-2507");
        const another_llama = await client.llm.load("qwen/qwen3-4b-2507", {
          identifier: "second-llama"
        });
```

<!-- Learn more about the `.load()` method and the parameters it accepts in the [API Reference](../api-reference/load). -->

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

        const model = await client.llm.model();
        await model.unload();
```

## Set Custom Load Config Parameters

You can also specify the same load-time configuration options when loading a model, such as Context Length and GPU offload.

See [load-time configuration](../llm-prediction/parameters) for more.

## Set an Auto Unload Timer (TTL)

You can specify a _time to live_ for a model you load, which is the idle time (in seconds)
after the last request until the model unloads. See [Idle TTL](/docs/api/ttl-and-auto-evict) for more on this.

```lms_code_snippet
  variants:
    "Using .load":
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();

        const model = await client.llm.load("qwen/qwen3-4b-2507", {
          ttl: 300, // 300 seconds
        });
    "Using .model":
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();

        const model = await client.llm.model("qwen/qwen3-4b-2507", {
          // Note: specifying ttl in `.model` will only set the TTL for the model if the model is
          // loaded from this call. If the model was already loaded, the TTL will not be updated.
          ttl: 300, // 300 seconds
        });
```
