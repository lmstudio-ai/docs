---
title: Structured Output
description: Enforce LLM response formats using JSON schemas.
index: 2
---

You can enforce a particular response format from an LLM by providing a JSON schema to the `/v1/chat/completions` endpoint, via LM Studio's REST API (or via any OpenAI client).

<hr>

### Start LM Studio as a server

To use LM Studio programmatically from your own code, run LM Studio as a local server.

You can turn on the server from the "Developer" tab in LM Studio, or via the `lms` CLI:

```
lms server start
```

###### Install `lms` by running `npx lmstudio install-cli`

This will allow you to interact with LM Studio via the REST API. For an intro to LM Studio's REST API, see [REST API Overview](/docs/developer/rest).

### Structured Output

The API supports structured JSON outputs through the `/v1/chat/completions` endpoint when given a [JSON schema](https://json-schema.org/overview/what-is-jsonschema). Doing this will cause the LLM to respond in valid JSON conforming to the schema provided.

It follows the same format as OpenAI's recently announced [Structured Output](https://platform.openai.com/docs/guides/structured-outputs) API and is expected to work via the OpenAI client SDKs.

**Example using `curl`**

This example demonstrates a structured output request using the `curl` utility.

To run this example on Mac or Linux, use any terminal. On Windows, use [Git Bash](https://git-scm.com/download/win).

```bash
curl http://localhost:1234/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "{{model}}",
    "messages": [
      {
        "role": "system",
        "content": "You are a helpful jokester."
      },
      {
        "role": "user",
        "content": "Tell me a joke."
      }
    ],
    "response_format": {
      "type": "json_schema",
      "json_schema": {
        "name": "joke_response",
        "strict": "true",
        "schema": {
          "type": "object",
          "properties": {
            "joke": {
              "type": "string"
            }
          },
          "required": ["joke"]
        }
      }
    },
    "temperature": 0.7,
    "max_tokens": 50,
    "stream": false
  }'
```

All parameters recognized by `/v1/chat/completions` will be honored, and the JSON schema should be provided in the `json_schema` field of `response_format`.

The JSON object will be provided in `string` form in the typical response field, `choices[0].message.content`, and will need to be parsed into a JSON object.

**Example using `python`**

```python
from openai import OpenAI
import json

# Initialize OpenAI client that points to the local LM Studio server
client = OpenAI(
    base_url="http://localhost:1234/v1",
    api_key="lm-studio"
)

# Define the conversation with the AI
messages = [
    {"role": "system", "content": "You are a helpful AI assistant."},
    {"role": "user", "content": "Create 1-3 fictional characters"}
]

# Define the expected response structure
character_schema = {
    "type": "json_schema",
    "json_schema": {
        "name": "characters",
        "schema": {
            "type": "object",
            "properties": {
                "characters": {
                    "type": "array",
                    "items": {
                        "type": "object",
                        "properties": {
                            "name": {"type": "string"},
                            "occupation": {"type": "string"},
                            "personality": {"type": "string"},
                            "background": {"type": "string"}
                        },
                        "required": ["name", "occupation", "personality", "background"]
                    },
                    "minItems": 1,
                }
            },
            "required": ["characters"]
        },
    }
}

# Get response from AI
response = client.chat.completions.create(
    model="your-model",
    messages=messages,
    response_format=character_schema,
)

# Parse and display the results
results = json.loads(response.choices[0].message.content)
print(json.dumps(results, indent=2))
```

**Important**: Not all models are capable of structured output, particularly LLMs below 7B parameters.

Check the model card README if you are unsure if the model supports structured output.

### Structured output engine

- For `GGUF` models: utilize `llama.cpp`'s grammar-based sampling APIs.
- For `MLX` models: using [Outlines](https://github.com/dottxt-ai/outlines).

The MLX implementation is available on Github: [lmstudio-ai/mlx-engine](https://github.com/lmstudio-ai/mlx-engine).

<hr>

### Community

Chat with other LM Studio users, discuss LLMs, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).
