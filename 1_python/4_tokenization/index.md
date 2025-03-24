---
title: Tokenization
sidebar_title: Tokenizing text
description: Tokenize text using a model's tokenizer
---

Models use a tokenizer to internally convert text into "tokens" they can deal with more easily. LM Studio exposes this tokenizer for utility.

## Tokenize

You can tokenize a string with a loaded LLM or embedding model using the SDK.
In the below examples, the LLM reference can be replaced with an
embedding model reference without requiring any other changes.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        model = lms.llm()

        tokens = model.tokenize("Hello, world!")

        print(tokens) # Array of token IDs.
```

## Count tokens

If you only care about the number of tokens, simply check the length of the resulting array.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        token_count = len(model.tokenize("Hello, world!"))
        print("Token count:", token_count)
```

### Example: count context

You can determine if a given conversation fits into a model's context by doing the following:

1. Convert the conversation to a string using the prompt template.
2. Count the number of tokens in the string.
3. Compare the token count to the model's context length.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        def does_chat_fit_in_context(model: lms.LLM, chat: lms.Chat) -> bool:
            # Convert the conversation to a string using the prompt template.
            formatted = model.apply_prompt_template(chat)
            # Count the number of tokens in the string.
            token_count = len(model.tokenize(formatted))
            # Get the current loaded context length of the model
            context_length = model.get_context_length()
            return token_count < context_length

        model = lms.llm()

        chat = lms.Chat.from_history({
            "messages": [
                { "role": "user", "content": "What is the meaning of life." },
                { "role": "assistant", "content": "The meaning of life is..." },
                # ... More messages
            ]
        })

        print("Fits in context:", does_chat_fit_in_context(model, chat))

```
