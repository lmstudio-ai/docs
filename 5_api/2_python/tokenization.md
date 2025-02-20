---
title: Tokenization
description: Tokenize text using a model's tokenizer
---

## Overview

Models use a tokenizer to internally convert text into "tokens" they can deal with more easily.
LM Studio exposes this tokenizer for utility (for example, in order to check if a formatted
chat history exceeds the model's context length).

### Usage

You can tokenize a string with a loaded LLM or embedding model using the SDK
(in the below examples, `llm` can instead be replaced with an embedding model handle).

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()

        tokens = llm.tokenize("Hello, world!")

        # You can also pass an iterable of strings
        more_tokens = llm.tokenize(["Hello, world!", "Goodbye, world!"])

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()

            tokens = llm.tokenize("Hello, world!")

            # You can also pass an iterable of strings
            more_tokens = llm.tokenize(["Hello, world!", "Goodbye, world!"])
```

### Context length comparisons

The below examples check whether a conversation exceed a model's context length.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()

        # To check for a string, simply tokenize
        tokens = llm.tokenize("Hello, world!")

        # To check for a Chat, apply the prompt template first
        chat = lmstudio.Chat()
        chat.add_user_prompt("Hello, world!")
        templated_chat = llm.apply_prompt_template(chat)
        tokens = llm.tokenize(templated_chat)

        # If the prompt's length in tokens is less than the context length, you're good!
        is_okay = (len(tokens) < llm.get_context_length())

        # Note: the context length for a loaded model can be reconfigured without
        # invalidating existing handles, so care needs to be taken with caching
        # the context length locally in client applications

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()

            # To check for a string, simply tokenize
            tokens = llm.tokenize("Hello, world!")

            # To check for a Chat, apply the prompt template first
            chat = lmstudio.Chat()
            chat.add_user_prompt("Hello, world!")
            templated_chat = llm.apply_prompt_template(chat)
            tokens = llm.tokenize(templated_chat)

            # If the prompt's length in tokens is less than the context length, you're good!
            is_okay = (len(tokens) < llm.get_context_length())
```
