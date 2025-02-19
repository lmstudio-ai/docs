---
title: Apply Prompt Template
description: Apply a model's built-in prompt template to a conversation
---

## Overview

LLMs are text-in, text-out models. Thus conversations must first be converted to a string before feeding into the model. This conversion is done using a prompt template. LM Studio SDK allows you to quickly apply a model's prompt template to a given chat and get the formatted string back.

### Usage

You can apply a loaded LLM's prompt template to a `Chat` or JSON conversation history using the SDK.

```lms_protip
To check whether a conversation is over the context limit for a model,
use this in conjunction with [tokenization](/docs/api/sdk/tokenization)
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
```
