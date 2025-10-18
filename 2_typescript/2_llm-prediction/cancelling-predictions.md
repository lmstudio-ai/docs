---
title: Cancelling Predictions
description: Stop an ongoing prediction in `lmstudio-js`
index: 4
---

Sometimes you may want to halt a prediction before it finishes. For example, the user might change their mind or your UI may navigate away. `lmstudio-js` provides two simple ways to cancel a running prediction.

## 1. Call `.cancel()` on the prediction

Every prediction method returns an `OngoingPrediction` instance. Calling `.cancel()` stops generation and causes the final `stopReason` to be `"userStopped"`. In the example below we schedule the cancel call on a timer:

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const model = await client.llm.model("qwen2.5-7b-instruct");

        const prediction = model.respond("What is the meaning of life?", {
          maxTokens: 50,
        });
        setTimeout(() => prediction.cancel(), 1000); // cancel after 1 second

        const result = await prediction.result();
        console.info(result.stats.stopReason); // "userStopped"
```

## 2. Use an `AbortController`

If your application already uses an `AbortController` to propagate cancellation, you can pass its `signal` to the prediction method. Aborting the controller stops the prediction with the same `stopReason`:

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const model = await client.llm.model("qwen2.5-7b-instruct");

        const controller = new AbortController();
        const prediction = model.respond("What is the meaning of life?", {
          maxTokens: 50,
          signal: controller.signal,
        });
        setTimeout(() => controller.abort(), 1000); // cancel after 1 second

        const result = await prediction.result();
        console.info(result.stats.stopReason); // "userStopped"
```

Both approaches halt generation immediately, and the returned stats indicate that the prediction ended because you stopped it.
