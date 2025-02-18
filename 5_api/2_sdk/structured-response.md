---
title: Structured Response
description: Enforce a structured response from the model using Pydantic (Python), Zod (TypeScript), or JSON Schema
---

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

    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";
        import { z } from "zod";

        const Book = z.object({
          title: z.string(),
          author: z.string(),
          year: z.number().int()
        })

        const client = new LMStudioClient();
        const llm = await client.llm.model();

        const response = await llm.respond(
          "Tell me about The Hobbit.", { structured: Book }
        )

        process.stdout.write(response.content.title)
```
