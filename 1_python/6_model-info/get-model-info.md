---
title: Get Model Info
description: Get information about the model
---

## Overview

You can access general information and metadata about a model itself from a loaded
instance of that model.

### Usage

Given a model handle, LM Studio can be queried for all of the current details of that model
(in the below examples, `llm` can instead be replaced with an embedding model handle).

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()

        model_info = llm.get_info()

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()

            model_info = llm.get_info()
```

[//] # (TODO: Describe the available model info following the data type unification)
