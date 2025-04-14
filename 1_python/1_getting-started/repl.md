---
title: "Using `lmstudio-python` in REPL"
sidebar_title: "REPL Usage"
description: "You can use `lmstudio-python` in REPL (Read-Eval-Print Loop) to interact with LLMs, manage models, and more."
index: 2
---

To enable interactive use, `lmstudio-python` offers a convenience API which manages
its resources via `atexit` hooks, allowing a default synchronous client session
to be used across multiple interactive commands.

This convenience API is shown in the examples throughout the documentation as the
`Python (convenience API)` tab (alongside the `Python (scoped resource API)` examples,
which use `with` statements to ensure deterministic cleanup of network communication
resources).

The convenience API allows the standard Python REPL, or more flexible alternatives like
Juypter Notebooks, to be used to interact with AI models loaded into LM Studio. For
example:

```lms_code_snippet
  title: "Python REPL"
  variants:
    "Interactive chat session":
      language: python
      code: |
        >>> import lmstudio as lms
        >>> loaded_models = lms.list_loaded_models()
        >>> for idx, model in enumerate(loaded_models):
        ...     print(f"{idx:>3} {model}")
        ...
          0 LLM(identifier='qwen2.5-7b-instruct')
        >>> model = loaded_models[0]
        >>> chat = lms.Chat("You answer questions concisely")
        >>> chat = lms.Chat("You answer questions concisely")
        >>> chat.add_user_message("Tell me three fruits")
        UserMessage(content=[TextData(text='Tell me three fruits')])
        >>> print(model.respond(chat, on_message=chat.append))
        Banana, apple, orange.
        >>> chat.add_user_message("Tell me three more fruits")
        UserMessage(content=[TextData(text='Tell me three more fruits')])
        >>> print(model.respond(chat, on_message=chat.append))
        Mango, strawberry, avocado.
        >>> chat.add_user_message("How many fruits have you told me?")
        UserMessage(content=[TextData(text='How many fruits have you told me?')])
        >>> print(model.respond(chat, on_message=chat.append))
        You asked for three initial fruits and three more, so I've listed a total of six fruits.

```
