---
title: List Local Models
description: Query which models are currently downloaded
---

## Overview

You can see which models have been downloaded to the machine running LM Studio
using the SDK, so that you can [load them](/docs/api/sdk/load-and-access-models) for inference.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        downloaded = lm.list_downloaded_models()
        llm_only = lm.list_downloaded_models("llm")
        embedding_only = lm.list_downloaded_models("embedding")

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            downloaded = client.list_downloaded_models()
            llm_only = client.llm.list_downloaded()
            embedding_only = client.embedding.list_downloaded()
```
