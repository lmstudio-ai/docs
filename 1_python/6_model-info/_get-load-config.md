---
title: Get Load Config
description: Get the load configuration of the model
---

TODO: Python SDK has this interface hidden until we can translate server config info back to client configs

LM Studio allows you to configure certain parameters when loading a model
[through the server UI](/docs/advanced/per-model) or [through the API](/docs/api/sdk/load-model).

You can retrieve the config with which a given model was loaded using the SDK.
In the below examples, the LLM reference can be replaced with an
embedding model reference without requiring any other changes.

```lms_protip
Context length is a special case that [has its own method](/docs/api/sdk/get-context-length).
```

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        client = new LMStudioClient()
        model = client.llm.model()

        loadConfig = model.getLoadConfig()
```
