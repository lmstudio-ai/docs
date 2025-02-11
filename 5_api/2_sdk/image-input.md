---
title: Image Input
description: Provide an image as input to the models capable of processing images
---

Once you have [downloaded and loaded](/docs/1_basics/index) a large language model,
you can use it to respond to input through the API. This article covers chatting about images with a vision-language model, but you can also
[request text completions](/docs/5_api/2_sdk/completion),
[request chat responses](/docs/5_api/2_sdk/chat-completion), and
[get JSON structured output for programmatic use](/docs/5_api/2_sdk/structured-response).

Vision-language models (VLMs) are LLMs that can also accept image input
to describe and chat with images. You can upload images to conversations
with the SDK and chat with them using the `respond` method on a VLM handle.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()
        # TODO

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()
            # TODO

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.model();
        // TODO

```
