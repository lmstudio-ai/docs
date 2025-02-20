---
title: Apply Prompt Template
description: Apply a model's built-in prompt template to a conversation
---

## Overview

LLMs (Large Language Models) operate on a text-in, text-out basis. Before processing conversations through these models, the input must be converted into a properly formatted string using a prompt template. If you need to inspect or work with this formatted string directly, the LM Studio SDK provides a streamlined way to apply a model's prompt template to your conversations. Note that for regular LLM interactions, this conversion is handled automatically by the SDK.

### Usage

You can apply a loaded LLM's prompt template to a `Chat` or JSON conversation history using the SDK.

```lms_protip
To check whether a conversation is over the context limit for a model,
use this in conjunction with [tokenization](/docs/sdk/python/tokenization)
(see that page for details).
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
```
