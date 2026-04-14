---
title: Get Model Info
description: Get information about the model
---

You can access information about a loaded model using the `getInfo` method.

```typescript tab="LLM"
import { LMStudioClient } from "@lmstudio/sdk";

const client = new LMStudioClient();
const model = await client.llm.model();

const modelInfo = await model.getInfo();

console.info("Model Key", modelInfo.modelKey);
console.info("Current Context Length", model.contextLength);
console.info("Model Trained for Tool Use", modelInfo.trainedForToolUse);
// etc.
```

```typescript tab="Embedding Model"
import { LMStudioClient } from "@lmstudio/sdk";

const client = new LMStudioClient();
const model = await client.embedding.model();

const modelInfo = await model.getInfo();

console.info("Model Key", modelInfo.modelKey);
console.info("Current Context Length", modelInfo.contextLength);
// etc.
```
