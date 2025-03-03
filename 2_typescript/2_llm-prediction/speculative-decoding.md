---
title: Speculative Decoding
description: API to use a draft model in speculative decoding in `lmstudio-js`
index: 5
---

Speculative decoding is a technique that can substantially increase the generation speed of large language models (LLMs) without reducing response quality. See [Speculative Decoding](./../../app/advanced/speculative-decoding) for more info.

To use speculative decoding in `lmstudio-js`, simply provide a `draftModel` parameter when performing the prediction. You do not need to load the draft model separately.

```lms_code_snippet
  variants:
    "Non-streaming":
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();

        const mainModelKey = "qwen2.5-7b-instruct";
        const draftModelKey = "qwen2.5-0.5b-instruct";

        const model = await client.llm.model(mainModelKey);
        const result = await model.respond("What are the prime numbers between 0 and 100?", {
          draftModel: draftModelKey,
        });

        const { content, stats } = result;
        console.info(content);
        console.info(`Accepted ${stats.acceptedDraftTokensCount}/${stats.predictedTokensCount} tokens`);


    Streaming:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();

        const mainModelKey = "qwen2.5-7b-instruct";
        const draftModelKey = "qwen2.5-0.5b-instruct";

        const model = await client.llm.model(mainModelKey);
        const prediction = model.respond("What are the prime numbers between 0 and 100?", {
          draftModel: draftModelKey,
        });

        for await (const { content } of prediction) {
          process.stdout.write(content);
        }
        process.stdout.write("\n");

        const { stats } = await prediction.result();
        console.info(`Accepted ${stats.acceptedDraftTokensCount}/${stats.predictedTokensCount} tokens`);
```
