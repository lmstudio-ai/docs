---
title: Tokenization
description: Tokenize text using a model's tokenizer
---

Models use a tokenizer to internally convert text into "tokens" they can deal with more easily. LM Studio exposes this tokenizer for utility.

You can tokenize a string with a loaded LLM or embedding model using the SDK. In the below examples, `llm` can be replaced with an embedding model `emb`.

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

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.model();

        const tokens = await llm.tokenize("Hello, world!");

        // TODO: iterable of strings
```

The below examples check whether a conversation is over a LLM's context length
(replace `llm` with `emb` to check for an embedding model).

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()
        context_length = llm.get_context_length()

        # To check for a string, simply tokenize
        tokens = llm.tokenize("Hello, world!")

        # To check for a Chat, apply the prompt template first
        chat = lmstudio.Chat()
        chat.add_user_prompt("Hello, world!")
        templated_chat = llm.apply_prompt_template(chat)
        tokens = llm.tokenize(templated_chat)

        # If the prompt's length in tokens is less than the context length, you're good!
        is_okay = (len(tokens) < llm.get_context_length())

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

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();
        const llm = await client.llm.model();
        // TODO what are the equivalents for typescript
```
