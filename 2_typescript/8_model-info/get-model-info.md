---
title: Get Model Info
description: Get information about the model
---

You can access information about a loaded model using the `getInfo` method.

```lms_code_snippet
  variants:
    LLM:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const model = await client.llm.model();

        const modelInfo = await model.getInfo();

        console.info("Model Key", modelInfo.modelKey);
        console.info("Current Context Length", model.contextLength);
        console.info("Model Trained for Tool Use", modelInfo.trainedForToolUse);
        // etc.
    Embedding Model:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const model = await client.embedding.model();

        const modelInfo = await model.getInfo();

        console.info("Model Key", modelInfo.modelKey);
        console.info("Current Context Length", modelInfo.contextLength);
        // etc.
```
