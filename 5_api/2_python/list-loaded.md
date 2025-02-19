---
title: List Loaded Models
description: Query which models are currently loaded
---

## Overview

You can see which models are currently loaded in the LM Studio server using the SDK,
so that you can access them for inference or unload them.

### Usage

Call `listLoaded`/`list_loaded` on the desired model type (LLM/embedding).

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        all_loaded_models = lm.list_loaded_models()
        llm_only = lm.list_loaded_models("llm")
        embedding_only = lm.list_loaded_models("embedding")

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            all_loaded_models = client.list_loaded_models()
            llm_only = client.llm.list_loaded()
            embedding_only = client.embedding.list_loaded()
```
