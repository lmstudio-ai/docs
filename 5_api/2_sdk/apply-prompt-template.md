---
title: Apply Prompt Template
description: Apply a model's built-in prompt template to a conversation
---

To continue conversations, LLMs internally apply a prompt template to convert them into strings
that they can deal with more easily. LM Studio exposes this templater for utility.

You can apply a loaded LLM's prompt template to a `Chat` or JSON conversation history using the SDK.

```lms_protip
To check whether a conversation is over the context limit for a model,
use this in conjunction with [tokenization](/docs/5_api/2_sdk/tokenization)
(see that page).
```

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()
        chat = lm.Chat("You are a helpful assistant.")
        chat.add_user_message("What is LM Studio?")

        formatted_chat = llm.apply_prompt_template(chat)

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()
            chat = lm.Chat("You are a helpful assistant.")
            chat.add_user_message("What is LM Studio?")

            formatted_chat = llm.apply_prompt_template(chat)

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.model();

        // TODO: how does typescript do this
```
