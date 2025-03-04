---
title: Tool Definition
description: TODO...
index: 1
---

You can define tools as regular Python functions and pass them to the model in the `act()` call.
Alternatively, tools can be defined with `lmstudio.ToolFunctionDef` in order to control the
name and description passed to the language model.

## Anatomy of a Tool

Follow one of the following examples to define functions as tools (the first approach
is typically going to be the most convenient):

```lms_code_snippet
  variants:
    "Python function":
      language: python
      code: |
        # Type hinted functions with clear names and docstrings
        # may be used directly as tool definitions
        def add(a: int, b: int) -> int:
            """Given two numbers a and b, returns the sum of them."""
            # The SDK ensures arguments are coerced to their specified types
            return a + b

        # Pass `add` directly to `act()` as a tool definition

    "ToolFunctionDef.from_callable":
      language: python
      code: |
        from lmstudio import ToolFunctionDef

        def cryptic_name(a: int, b: int) -> int:
            return a + b

        # Type hinted functions with cryptic names and missing or poor docstrings
        # can be turned into clear tool definitions with `from_callable`
        tool_def = ToolFunctionDef.from_callable(
          cryptic_name,
          name="add",
          description="Given two numbers a and b, returns the sum of them."
        )
        # Pass `tool_def` to `act()` as a tool definition

    "ToolFunctionDef":
      language: python
      code: |
        from lmstudio import ToolFunctionDef

        def cryptic_name(a, b):
            return a + b

        # Functions without type hints can be used without wrapping them
        # at runtime by defining a tool function directly.
        tool_def = ToolFunctionDef(
          name="add",
          description="Given two numbers a and b, returns the sum of them.",
          parameters={
            "a": int,
            "b": int,
          },
          implementation=cryptic_name,
        )
        # Pass `tool_def` to `act()` as a tool definition

```

**Important**: The tool name, description, and the parameter definitions are all passed to the model!

This means that your wording will affect the quality of the generation. Make sure to always provide a clear description of the tool so the model knows how to use it.

The SDK does not yet automatically convert raised exceptions to text and report them
to the language model, but it can be beneficial for tool implementations to do so.
In many cases, when notified of an error, a language model is able to adjust its
request to avoid the failure.


## Tools with External Effects (like Computer Use or API Calls)

Tools can also have external effects, such as creating files or calling programs and even APIs. By implementing tools with external effects, you
can essentially turn your LLMs into autonomous agents that can perform tasks on your local machine.

## Example: `create_file_tool`

### Tool Definition

```lms_code_snippet
  title: "create_file_tool.py"
  variants:
    Python:
      language: python
      code: |
        from pathlib import Path

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

```

### Example code using the `create_file` tool:

```lms_code_snippet
  title: "example.py"
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms
        from create_file_tool import create_file

        model = lms.llm("qwen2.5-7b-instruct")
        model.act(
          "Please create a file named output.txt with your understanding of the meaning of life.",
          [create_file],
        )
```
