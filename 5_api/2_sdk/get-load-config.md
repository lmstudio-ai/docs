---
title: Get Load Config
description: Get the load configuration of the model
---

## Overview

LM Studio allows you to configure certain parameters when loading a model
[through the server UI](/docs/advanced/per-model) or [through the API](/docs/api/sdk/load-model).

### Usage

You can retrieve the config with which a given model was loaded using the SDK. In the below examples, `llm` can be replaced with an embedding model `emb`.

```lms_protip
Context length is a special case that [has its own method](/docs/api/sdk/get-context-length).
```

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()

        load_config = llm.get_load_config()

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()

            load_config = llm.get_load_config()

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.model();

        loadConfig = await llm.getLoadConfig()
```
