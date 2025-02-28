---
title: Structured Response
description: Enforce a structured response from the model using Pydantic (Python), Zod (TypeScript), or JSON Schema
index: 4
---

You can enforce a particular response format from an LLM by providing a schema (JSON or `zod`) to the `.respond()` method. This guarantees that the model's output conforms to the schema you provide.

## Enforce Using a `zod` Schema

If you wish the model to generate JSON that satisfies a given schema, it is recommended to provide
the schema using [`zod`](https://zod.dev/). When a `zod` schema is provided, the prediction result will contain an extra field `parsed`, which contains parsed, validated, and typed result.

#### Define a `zod` Schema

```ts
import { z } from "zod";

// A zod schema for a book
const bookSchema = z.object({
  title: z.string(),
  author: z.string(),
  year: z.number().int(),
});
```

#### Generate a Structured Response

```lms_code_snippet
  variants:
    "Non-streaming":
      language: typescript
      code: |
        const result = await model.respond("Tell me about The Hobbit.",
          { structured: bookSchema }
        );

        const book = result.parsed;
        console.info(book);
        //           ^
        // Note that `book` is now correctly typed as { title: string, author: string, year: number }

    Streaming:
      language: typescript
      code: |
        const prediction = model.respond("Tell me about The Hobbit.",
          { structured: bookSchema }
        );

        // Optionally stream the response
        // for await (const { content } of prediction) {
        //   process.stdout.write(content);
        // }
        // console.info();

        // Get the final structured result
        const result = await prediction.result();
        const book = result.parsed;

        console.info(book);
        //           ^
        // Note that `book` is now correctly typed as { title: string, author: string, year: number }
```

## Enforce Using a JSON Schema

You can also enforce a structured response using a JSON schema.

#### Define a JSON Schema

```ts
// A JSON schema for a book
const schema = {
  type: "object",
  properties: {
    title: { type: "string" },
    author: { type: "string" },
    year: { type: "integer" },
  },
  required: ["title", "author", "year"],
};
```

#### Generate a Structured Response

```lms_code_snippet
  variants:
    "Non-streaming":
      language: typescript
      code: |
        const result = await model.respond("Tell me about The Hobbit.", {
          structured: {
            type: "json",
            jsonSchema: schema,
          },
        });

        const book = JSON.parse(result.content);
        console.info(book);
    Streaming:
      language: typescript
      code: |
        const prediction = model.respond("Tell me about The Hobbit.", {
          structured: {
            type: "json",
            jsonSchema: schema,
          },
        });

        for await (const { content } of prediction) {
          process.stdout.write(content);
        }
        console.info(); // Print a newline

        const result = await prediction.result();
        const book = JSON.parse(result.content);

        console.info("Parsed", book);
```

TODO: Info about structured generation caveats

<!-- ## Overview

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
          "Tell me about The Hobbit.",
          { structured: Book },
        )

        console.log(response.content.title)
``` -->
