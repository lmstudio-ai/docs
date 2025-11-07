---
title: Idle TTL and Auto-Evict
description: Optionally auto-unload idle models after a certain amount of time (TTL)
index: 4
---

## Background

- `JIT loading` makes it easy to use your LM Studio models in other apps: you don't need to manually load the model first before being able to use it. However, this also means that models can stay loaded in memory even when they're not being used. `[Default: enabled]`

- (New) `Idle TTL` (technically: Time-To-Live) defines how long a model can stay loaded in memory without receiving any requests. When the TTL expires, the model is automatically unloaded from memory. You can set a TTL using the `ttl` field in your request payload. `[Default: 60 minutes]`

- (New) `Auto-Evict` is a feature that unloads previously JIT loaded models before loading new ones. This enables easy switching between models from client apps without having to manually unload them first. You can enable or disable this feature in Developer tab > Server Settings. `[Default: enabled]`

## Idle TTL

**Use case**: imagine you're using an app like [Zed](https://github.com/zed-industries/zed/blob/main/crates/lmstudio/src/lmstudio.rs#L340), [Cline](https://github.com/cline/cline/blob/main/src/api/providers/lmstudio.ts), or [Continue.dev](https://docs.continue.dev/customize/model-providers/more/lmstudio) to interact with LLMs served by LM Studio. These apps leverage JIT to load models on-demand the first time you use them.

**Problem**: When you're not actively using a model, you might don't want it to remain loaded in memory.

**Solution**: Set a TTL for models loaded via API requests. The idle timer resets every time the model receives a request, so it won't disappear while you use it. A model is considered idle if it's not doing any work. When the idle TTL expires, the model is automatically unloaded from memory.

### Set App-default Idle TTL

By default, JIT-loaded models have a TTL of 60 minutes. You can configure a default TTL value for any model loaded via JIT like so:

<img src="/assets/docs/app-default-ttl.png" style="width: 500px; " data-caption="Set a default TTL value. Will be used for all JIT loaded models unless specified otherwise in the request payload" />

### Set per-model TTL-model in API requests

When JIT loading is enabled, the **first request** to a model will load it into memory. You can specify a TTL for that model in the request payload.

This works for requests targeting both the [OpenAI compatibility API](/docs/developer/openai-api) and the [LM Studio's REST API](/docs/developer/rest):

```diff
curl http://localhost:1234/api/v0/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "deepseek-r1-distill-qwen-7b",
+   "ttl": 300,
    "messages": [ ... ]
}'
```

###### This will set a TTL of 5 minutes (300 seconds) for this model if it is JIT loaded.

### Set TTL for models loaded with `lms`

By default, models loaded with `lms load` do not have a TTL, and will remain loaded in memory until you manually unload them.

You can set a TTL for a model loaded with `lms` like so:

```bash
lms load <model> --ttl 3600
```

###### Load a `<model>` with a TTL of 1 hour (3600 seconds)

### Specify TTL when loading models in the server tab

You can also set a TTL when loading a model in the server tab like so

<img src="/assets/docs/ttl-server-model.png" style="width: 100%;" data-caption="Set a TTL value when loading a model in the server tab" />

## Configure Auto-Evict for JIT loaded models

With this setting, you can ensure new models loaded via JIT automatically unload previously loaded models first.

This is useful when you want to switch between models from another app without worrying about memory building up with unused models.

<img src="/assets/docs/auto-evict-and-ttl.png" style="width: 500px; margin-top:30px" data-caption="Enable or disable Auto-Evict for JIT loaded models in the Developer tab > Server Settings" />

**When Auto-Evict is ON** (default):

- At most `1` model is kept loaded in memory at a time (when loaded via JIT)
- Non-JIT loaded models are not affected

**When Auto-Evict is OFF**:

- Switching models from an external app will keep previous models loaded in memory
- Models will remain loaded until either:
  - Their TTL expires
  - You manually unload them

This feature works in tandem with TTL to provide better memory management for your workflow.

### Nomenclature

`TTL`: Time-To-Live, is a term borrowed from networking protocols and cache systems. It defines how long a resource can remain allocated before it's considered stale and evicted.
