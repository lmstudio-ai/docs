---
title: Messages
description: Send a Messages request and get the assistant's response.
index: 2
api_info:
  method: POST
---

- Method: `POST`
- Endpoint: `/v1/messages`
- See Anthropic docs: https://platform.claude.com/docs/en/api/messages/create

##### cURL example

```bash
curl http://localhost:1234/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: $LM_API_TOKEN" \
  -d '{
    "model": "ibm/granite-4-micro",
    "max_tokens": 256,
    "messages": [
      {"role": "user", "content": "Say hello from LM Studio."}
    ]
  }'
```

If you have not enabled Require Authentication, the `x-api-key` header is optional.

##### cURL (streaming)

```bash
curl http://localhost:1234/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: $LM_API_TOKEN" \
  -d '{
    "model": "ibm/granite-4-micro",
    "messages": [{"role": "user", "content": "Hello"}],
    "max_tokens": 256,
    "stream": true
  }'
```

You will receive SSE events such as `message_start`, `content_block_start`, `content_block_delta`, `content_block_stop`, `message_delta`, and `message_stop`.

##### cURL (tools)

```bash
curl http://localhost:1234/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: $LM_API_TOKEN" \
  -d '{
    "model": "ibm/granite-4-micro",
    "max_tokens": 1024,
    "tools": [
      {
        "name": "get_weather",
        "description": "Get the current weather in a given location",
        "input_schema": {
          "type": "object",
          "properties": {
            "location": {
              "type": "string",
              "description": "The city and state, e.g. San Francisco, CA"
            }
          },
          "required": ["location"]
        }
      }
    ],
    "tool_choice": {"type": "any"},
    "messages": [
      {
        "role": "user",
        "content": "What is the weather like in San Francisco?"
      }
    ]
  }'
```
