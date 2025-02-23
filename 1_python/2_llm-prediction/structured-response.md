---
title: Structured Output
description: Enforce a structured response from the model using Pydantic (Python), Zod (TypeScript), or JSON Schema
---

## Overview

By default, [assistant chat response predictions](/docs/sdk/python/chat-completion) and
[text completion predictions](/docs/sdk/python/completion) are returned as plain text,
the same format used to provide system prompts and user messages when sending requests.

For programmatic AI use cases, it may instead be preferable to request that responses
use a structured JSON format rather than raw text.

### Usage

Certain models are trained to output valid JSON data that conforms to
a user-provided schema, which can be used programmatically in applications
that need structured data. Structured responses are requested via the `response_format`
keyword only parameter on the prediction request methods (`complete()`,
`complete_stream()`, `respond()`, `respond_stream()`).

Format specifications may be in the form of either a JSON schema dict, or any
Python class which implements a `model_json_schema()` class method. Most notably,
the latter allows `pydantic.BaseModel` subclasses to be used to request structured
responses.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm
        from pydantic import BaseModel

        class Book(BaseModel):
            title: str
            author: str
            year: int

        llm = lm.llm()

        dict_response = llm.respond(
            "Tell me about The Hobbit.",
            response_format=Book,
        )

        print(dict_response.content["title"])

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio
        from pydantic import BaseModel

        class Book(BaseModel):
            title: str
            author: str
            year: int

        with lmstudio.Client() as client:
            llm = client.llm.model()

            dict_response = llm.respond(
                "Tell me about The Hobbit.",
                response_format=Book,
            )

            print(dict_response.content["title"])
```
