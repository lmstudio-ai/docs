---
title: The `.act()` call
description: TODO...
index: 2
---

## Agents

LLMs are text-in text-out models and cannot directly execute code. However, just like an ancient general can command an army with their voices alone, if we ask the LLM to output text in a certain format when it wants to use an external tool, and execute those requests on its behave, we can effectively turn LLMs into autonomous agents that can perform tasks on your local machine.

### Quick Example

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        def multiply(a: float, b: float) -> float:
            """Given two numbers a and b. Returns the product of them."""
            return a * b

        model = lms.llm("qwen2.5-7b-instruct")
        model.act(
          "What is the result of 12345 multiplied by 54321?",
          [multiply],
          on_message=print,
        )
```

### Important: Model Selection

The model selected for tool use will greatly impact performance.

Some general guidance when selecting a model:

- Not all models are capable of intelligent tool use
- Bigger is better (i.e., a 7B parameter model will generally perform better than a 3B parameter model)
- We've observed [Qwen2.5-7B-Instruct](https://model.lmstudio.ai/download/lmstudio-community/Qwen2.5-7B-Instruct-GGUF) to perform well in a wide variety of cases
- This guidance may change

### Example: Multiple Tools

The following code demonstrates how to provide multiple tools in a single `.act()` call.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import math
        import lmstudio as lms

        def add(a: int, b: int) -> int:
            """Given two numbers a and b, returns the sum of them."""
            return a + b

        def is_prime(n: int) -> bool:
            """Given a number n, returns True if n is a prime number."""
            if n < 2:
                return False
            sqrt = int(math.sqrt(n))
            for i in range(2, sqrt):
                if n % i == 0:
                    return False
            return True

        model = lms.llm("qwen2.5-7b-instruct")
        model.act(
          "Is the result of 12345 + 45668 a prime? Think step by step.",
          [add, is_prime],
          on_message=print,
        )
```

### Example: Chat Loop with Create File Tool

The following code creates a conversation loop with an LLM agent that can create files.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |

        import readline # Enables input line editing
        from pathlib import Path

        import lmstudio as lms

        def create_file(name: str, content: str):
            """Create a file with the given name and content."""
            dest_path = Path(name)
            if dest_path.exists():
                return "Error: File already exists."
            try:
                dest_path.write_text(content, encoding="utf-8")
            except Exception as exc:
                return "Error: {exc!r}"
            return "File created."

        def print_content(fragment):
            print(fragment.content, end="", flush=True)

        model = lms.llm()
        chat = lms.Chat("You are a task focused AI assistant")

        while True:
            try:
                user_input = input("You (leave blank to exit): ")
            except EOFError:
                print()
                break
            if not user_input:
                break
            chat.add_user_message(user_input)
            print("Bot: ", end="", flush=True)
            model.act(
                chat,
                on_message=chat.append,
                on_fragment=print_fragment,
            )
            print()

```
