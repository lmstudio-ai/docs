---
title: Load and Access Models
description: Load, access, and unload models from the server
---


### Load a new instance of a model

Calling `model()` will not load a new instance (copy) of a model if one already exists.
If you intentionally want to have multiple instances of the same model alive
at the same time, the SDK allows you to do so. Again, you'll need the model key,
but this time you can specify a custom _instance identifier_ to distinguish the
instance you're loading from the others.

```lms_protip
If you provide an instance identifier that already exists, the server will throw an error.
So if you don't really care, it's safer to leave out the identifier, in which case
the server will generate one for you. You can always check in the server tab, too!
```

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();

        const llama = await client.llm.load_new_instance("llama-3.2-1b-instruct");
        const another_llama = await client.llm.load_new_instance("llama-3.2-1b-instruct", "second-llama");
```

### Unload a model

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
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();

        // TODO ttl in typescript?
        const llama = await client.llm.model("llama-3.2-1b-instruct");
        const another_llama = await client.llm.load_new_instance("llama-3.2-1b-instruct");
```

### Progress callbacks

Loading a model requires transferring all the weights from disk to RAM/VRAM,
which can take a long time depending on your disk read speed and the size of the model.
If you want to get updates on the progress of this process, you can provide a float callback to `loadNewInstance`/`load_new_instance`
that receives a float from 0.0-1.0 representing load progress.

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();

        const llama = await client.llm.load_new_instance(
          "llama-3.2-1b-instruct",
          {onProgress: (progress) => process.stdout.write(`${progress*100}% loaded`)},
        );
```

### Load config

You can also specify the same load configuration options as you could in the
in-app loading dropdown. Please consult your specific SDK to see exact syntax.
