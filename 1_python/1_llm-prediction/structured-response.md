---
title: Structured Response
description: Enforce a structured response from the model using Pydantic models or JSON Schema
index: 4
---

You can enforce a particular response format from an LLM by providing a JSON schema to the `.respond()` method.
This guarantees that the model's output conforms to the schema you provide.

The JSON schema can either be provided directly,
or by providing an object that implements the `lmstudio.ModelSchema` protocol,
such as `pydantic.BaseModel` or `lmstudio.BaseModel`.

The `lmstudio.ModelSchema` protocol is defined as follows:

```python
@runtime_checkable
class ModelSchema(Protocol):
    """Protocol for classes that provide a JSON schema for their model."""

    @classmethod
    def model_json_schema(cls) -> DictSchema:
        """Return a JSON schema dict describing this model."""
        ...

```

When a schema is provided, the prediction result's `parsed` field will contain a string-keyed dictionary that conforms
to the given schema (for unstructured results, this field is a string field containing the same value as `content`).


## Enforce Using a Class Based Schema Definition

If you wish the model to generate JSON that satisfies a given schema,
it is recommended to provide a class based schema definition using a library
such as [`pydantic`](https://docs.pydantic.dev/) or [`msgspec`](https://jcristharif.com/msgspec/).

Pydantic models natively implement the `lmstudio.ModelSchema` protocol,
while `lmstudio.BaseModel` is a `msgspec.Struct` subclass that implements `.model_json_schema()` appropriately.

#### Define a Class Based Schema

```lms_code_snippet
  variants:
    "pydantic.BaseModel":
      language: python
      code: |
        from pydantic import BaseModel

        # A class based schema for a book
        class BookSchema(BaseModel):
            title: str
            author: str
            year: int

    "lmstudio.BaseModel":
      language: python
      code: |
        from lmstudio import BaseModel

        # A class based schema for a book
        class BookSchema(BaseModel):
            title: str
            author: str
            year: int

```

#### Generate a Structured Response

```lms_code_snippet
  variants:
    "Non-streaming":
      language: python
      code: |
        result = model.respond("Tell me about The Hobbit", response_format=BookSchema)
        book = result.parsed

        print(book)
        #           ^
        # Note that `book` is correctly typed as { title: string, author: string, year: number }

    Streaming:
      language: python
      code: |
        prediction_stream = model.respond_stream("Tell me about The Hobbit", response_format=BookSchema)

        # Optionally stream the response
        # for fragment in prediction:
        #   print(fragment.content, end="", flush=True)
        # print()
        # Note that even for structured responses, the *fragment* contents are still only text

        # Get the final structured result
        result = prediction_stream.result()
        book = result.parsed

        print(book)
        #           ^
        # Note that `book` is correctly typed as { title: string, author: string, year: number }
```

## Enforce Using a JSON Schema

You can also enforce a structured response using a JSON schema.

#### Define a JSON Schema

```python
# A JSON schema for a book
schema = {
  "type": "object",
  "properties": {
    "title": { "type": "string" },
    "author": { "type": "string" },
    "year": { "type": "integer" },
  },
  "required": ["title", "author", "year"],
}
```

#### Generate a Structured Response

```lms_code_snippet
  variants:
    "Non-streaming":
      language: python
      code: |
        result = model.respond("Tell me about The Hobbit", response_format=schema)
        book = result.parsed

        print(book)
        #     ^
        # Note that `book` is correctly typed as { title: string, author: string, year: number }

    Streaming:
      language: python
      code: |
        prediction_stream = model.respond_stream("Tell me about The Hobbit", response_format=schema)

        # Stream the response
        for fragment in prediction:
            print(fragment.content, end="", flush=True)
        print()
        # Note that even for structured responses, the *fragment* contents are still only text

        # Get the final structured result
        result = prediction_stream.result()
        book = result.parsed

        print(book)
        #     ^
        # Note that `book` is correctly typed as { title: string, author: string, year: number }
```

<!--

TODO: Info about structured generation caveats

 ## Overview

Once you have [downloaded and loaded](/docs/basics/index) a large language model,
you can use it to respond to input through the API. This article covers getting JSON structured output, but you can also
[request text completions](/docs/api/sdk/completion),
[request chat responses](/docs/api/sdk/chat-completion), and
[use a vision-language model to chat about images](/docs/api/sdk/image-input).

### Usage

Certain models are trained to output valid JSON data that conforms to
a user-provided schema, which can be used programmatically in applications
that need structured data. This structured data format is supported by both
[`complete`](/docs/api/sdk/completion) and [`respond`](/docs/api/sdk/chat-completion)
methods, and relies on Pydantic in Python and Zod in TypeScript.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";
        import { z } from "zod";

        const Book = z.object({
          title: z.string(),
          author: z.string(),
          year: z.number().int()
        })

        const client = new LMStudioClient()
        const llm = client.llm.model()

        const response = llm.respond(
          "Tell me about The Hobbit.",
          { structured: Book },
        )

        console.log(response.content.title)
``` -->
