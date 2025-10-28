---
title: Responses
description: Create responses with support for streaming, reasoning, prior response state, and optional Remote MCP tools.
index: 3
api_info:
  method: POST
---

- Method: `POST`
- See OpenAI docs: https://platform.openai.com/docs/api-reference/responses

##### cURL (non‑streaming)

```bash
curl http://localhost:1234/v1/responses \
  -H "Content-Type: application/json" \
  -d '{
    "model": "openai/gpt-oss-20b",
    "input": "Provide a prime number less than 50",
    "reasoning": { "effort": "low" }
  }'
```

##### Stateful follow‑up

Use the `id` from a previous response as `previous_response_id`.

```bash
curl http://localhost:1234/v1/responses \
  -H "Content-Type: application/json" \
  -d '{
    "model": "openai/gpt-oss-20b",
    "input": "Multiply it by 2",
    "previous_response_id": "resp_123"
  }'
```

##### Streaming

```bash
curl http://localhost:1234/v1/responses \
  -H "Content-Type: application/json" \
  -d '{
    "model": "openai/gpt-oss-20b",
    "input": "Hello",
    "stream": true
  }'
```

You will receive SSE events such as `response.created`, `response.output_text.delta`, and `response.completed`.

##### Tools and Remote MCP (opt‑in)

Enable Remote MCP in the app (Developer → Settings). Example payload using an MCP server tool:

```bash
curl http://localhost:1234/v1/responses \
  -H "Content-Type: application/json" \
  -d '{
    "model": "openai/gpt-oss-20b",
    "tools": [{
      "type": "mcp",
      "server_label": "tiktoken",
      "server_url": "https://gitmcp.io/openai/tiktoken",
      "allowed_tools": ["fetch_tiktoken_documentation"]
    }],
    "input": "What is the first sentence of the tiktoken documentation?"
  }'
```
