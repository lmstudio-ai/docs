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
          { structured: bookSchema },
          maxTokens: 100, // Recommended to avoid getting stuck
        );

        const book = result.parsed;
        console.info(book);
        //           ^
        // Note that `book` is now correctly typed as { title: string, author: string, year: number }

    Streaming:
      language: typescript
      code: |
        const prediction = model.respond("Tell me about The Hobbit.",
          { structured: bookSchema },
          maxTokens: 100, // Recommended to avoid getting stuck
        );

        for await (const { content } of prediction) {
          process.stdout.write(content);
        }
        process.stdout.write("\n");

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
          maxTokens: 100, // Recommended to avoid getting stuck
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
          maxTokens: 100, // Recommended to avoid getting stuck
        });

        for await (const { content } of prediction) {
          process.stdout.write(content);
        }
        process.stdout.write("\n");

        const result = await prediction.result();
        const book = JSON.parse(result.content);

        console.info("Parsed", book);
```

```lms_warning
Structured generation works by constraining the model to only generate tokens that conform to the provided schema. This ensures valid output in normal cases, but comes with two important limitations:

1. Models (especially smaller ones) may occasionally get stuck in an unclosed structure (like an open bracket), when they "forget" they are in such structure and cannot stop due to schema requirements. Thus, it is recommended to always include a `maxTokens` parameter to prevent infinite generation.

2. Schema compliance is only guaranteed for complete, successful generations. If generation is interrupted (by cancellation, reaching the `maxTokens` limit, or other reasons), the output will likely violate the schema. With `zod` schema input, this will raise an error; with JSON schema, you'll receive an invalid string that doesn't satisfy schema.
```

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
