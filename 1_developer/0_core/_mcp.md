---
title: Using MCP via API
sidebar_title: Using MCP via API
description: Learn how to use Model Control Protocol (MCP) servers with LM Studio API.
index: 4
---

LM Studio supports Model Control Protocol (MCP) usage via API starting from version 0.4.0. MCP allows models to interact with external tools and services through standardized servers.

## How it works

MCP servers provide tools that models can call during chat requests. You can enable MCP servers in two ways: as ephemeral servers defined per-request, or as pre-configured servers in your `mcp.json` file.

## Ephemeral MCP servers

Ephemeral MCP servers are defined on-the-fly in each request. This is useful for testing or when you don't want to pre-configure servers.

```lms_info
Ephemeral MCP servers require the "Allow Ephemeral Remote MCPs" setting to be enabled in [Server Settings](/docs/developer/core/server/settings).
```

```lms_code_snippet
variants:
  curl:
    language: bash
    code: |
      curl http://localhost:1234/api/v1/chat \
        -H "Authorization: Bearer $LM_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "model": "qwen/qwen3-4b-2507",
          "input": "What is the architecture of the Qwen3-Coder-480B-A35B-Instruct. Look at hugging face repo details",
          "integrations": [
            {
              "type": "ephemeral_mcp",
              "server_label": "huggingface",
              "server_url": "https://huggingface.co/mcp",
              "allowed_tools": ["hub_repo_details"]
            }
          ],
          "context_length": 10000
        }'
  Python:
    language: python
    code: |
      import os
      import requests

      response = requests.post(
          "http://localhost:1234/api/v1/chat",
          headers={
              "Authorization": f"Bearer {os.environ['LM_API_TOKEN']}",
              "Content-Type": "application/json"
          },
          json={
              "model": "qwen/qwen3-4b-2507",
              "input": "What is the architecture of the Qwen3-Coder-480B-A35B-Instruct. Look at hugging face repo details",
              "integrations": [
                  {
                      "type": "ephemeral_mcp",
                      "server_label": "huggingface",
                      "server_url": "https://huggingface.co/mcp",
                      "allowed_tools": ["hub_repo_details"]
                  }
              ],
              "context_length": 10000
          }
      )
      print(response.json())
  TypeScript:
    language: typescript
    code: |
      const response = await fetch("http://localhost:1234/api/v1/chat", {
        method: "POST",
        headers: {
          "Authorization": `Bearer ${process.env.LM_API_TOKEN}`,
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          model: "qwen/qwen3-4b-2507",
          input: "What is the architecture of the Qwen3-Coder-480B-A35B-Instruct. Look at hugging face repo details",
          integrations: [
            {
              type: "ephemeral_mcp",
              server_label: "huggingface",
              server_url: "https://huggingface.co/mcp",
              allowed_tools: ["hub_repo_details"]
            }
          ],
          context_length: 10000
        })
      });
      const data = await response.json();
      console.log(data);
```

The model can now call tools from the specified MCP server:

```lms_code_snippet
variants:
  response:
    language: json
    code: |
      {
        "model_instance_id": "qwen/qwen3-4b-2507",
        "output": [
          {
            "type": "tool_call",
            "tool": "hub_repo_details",
            "arguments": {
              "repo_ids": [
                "Qwen/Qwen3-Coder-480B-A35B-Instruct"
              ],
              "repo_type": "model"
            },
            "output": "...",
            "provider_info": {
              "server_label": "huggingface",
              "type": "ephemeral_mcp"
            }
          },
          {
            "type": "message",
            "content": "The architecture of the **Qwen3-Coder-480B-A35B-Instruct** model is **qwen3_moe**. \n\nThis information is derived from the repository details provided by Hugging Face, which specify the model's architecture under the \"Technical Details\" section. Let me know if you'd like further details!"
          }
        ],
        "stats": {
          "input_tokens": 308,
          "total_output_tokens": 118,
          "reasoning_output_tokens": 0,
          "tokens_per_second": 49.44322495154522,
          "time_to_first_token_seconds": 0.217
        },
        "thread_id": "thread_0014d69c854c74594fb9bfef9ac4b3a6c8a776fad1f7c3d1"
      }
```

## MCP servers from mcp.json

MCP servers can be pre-configured in your `mcp.json` file. This is the recommended approach for servers you use frequently.

```lms_info
MCP servers from mcp.json require the "Allow calling servers from mcp.json" setting to be enabled in [Server Settings](/docs/developer/core/server/settings).
```

```lms_code_snippet
variants:
  curl:
    language: bash
    code: |
      curl http://localhost:1234/api/v1/chat \
        -H "Authorization: Bearer $LM_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "model": "openai/gpt-oss-20b",
          "input": "use the mcp to rickroll me",
          "integrations": ["mcp/playwright"]
        }'
  Python:
    language: python
    code: |
      import os
      import requests

      response = requests.post(
          "http://localhost:1234/api/v1/chat",
          headers={
              "Authorization": f"Bearer {os.environ['LM_API_TOKEN']}",
              "Content-Type": "application/json"
          },
          json={
              "model": "openai/gpt-oss-20b",
              "input": "use the mcp to rickroll me",
              "integrations": ["mcp/playwright"]
          }
      )
      print(response.json())
  TypeScript:
    language: typescript
    code: |
      const response = await fetch("http://localhost:1234/api/v1/chat", {
        method: "POST",
        headers: {
          "Authorization": `Bearer ${process.env.LM_API_TOKEN}`,
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          model: "openai/gpt-oss-20b",
          input: "use the mcp to rickroll me",
          integrations: ["mcp/playwright"]
        })
      });
      const data = await response.json();
      console.log(data);
```

The response includes tool calls from the configured MCP server:

```lms_code_snippet
variants:
  response:
    language: json
    code: |
      {
        "model_instance_id": "openai/gpt-oss-20b",
        "output": [
          {
            "type": "reasoning",
            "content": "The user wants: .....  Let's do that."
          },
          {
            "type": "tool_call",
            "tool": "browser_navigate",
            "arguments": {
              "url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
            },
            "output": "[...]",
            "provider_info": {
              "plugin_id": "mcp/playwright",
              "type": "plugin"
            }
          },
          {
            "type": "message",
            "content": "Here's the link to your rickroll – I've opened it for you in a new tab using Playwright:\n\n> **https://www.youtube.com/watch?v=dQw4w9WgXcQ**\n\nEnjoy the classic "Never Gonna Give You Up" video! 🎶"
          }
        ],
        "stats": {
          "input_tokens": 1428,
          "total_output_tokens": 460,
          "reasoning_output_tokens": 354,
          "tokens_per_second": 42.7891711368994,
          "time_to_first_token_seconds": 2.806
        },
        "thread_id": "thread_d26d96a8f3c0c15601f12fde1c682f24b65bb5b302c81795"
      }
```

## Ephemeral vs mcp.json servers

| Feature | Ephemeral | mcp.json |
|---------|-----------|--------|
| Configuration | Defined in each request | Pre-configured in `mcp.json` |
| Use case | Testing, one-off requests | Frequent use, stable servers |
| Server ID | Specified via `server_label` | Specified via `id` (e.g., `mcp/playwright`) |
| Custom headers | Supported via `headers` field | Configured in `mcp.json` |

## Restricting tool access

For both ephemeral and mcp.json servers, you can limit which tools the model can call using the `allowed_tools` field:

```lms_code_snippet
variants:
  curl:
    language: bash
    code: |
      curl http://localhost:1234/api/v1/chat \
        -H "Authorization: Bearer $LM_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "model": "qwen/qwen3-4b-2507",
          "input": "Find trending models using HF MCP and open the top one in my browser. Only open the top one, not the rest",
          "integrations": [
            {
              "type": "ephemeral_mcp",
              "server_label": "huggingface",
              "server_url": "https://huggingface.co/mcp",
              "allowed_tools": ["model_search"]
            },
            {
              "type": "plugin",
              "id": "mcp/playwright",
              "allowed_tools": ["browser_navigate"]
            }
          ],
          "context_length": 20000
        }'
  Python:
    language: python
    code: |
      import os
      import requests

      response = requests.post(
          "http://localhost:1234/api/v1/chat",
          headers={
              "Authorization": f"Bearer {os.environ['LM_API_TOKEN']}",
              "Content-Type": "application/json"
          },
          json={
              "model": "qwen/qwen3-4b-2507",
              "input": "Find trending models using HF MCP and open the top one in my browser. Only open the top one, not the rest",
              "integrations": [
                  {
                      "type": "ephemeral_mcp",
                      "server_label": "huggingface",
                      "server_url": "https://huggingface.co/mcp",
                      "allowed_tools": ["model_search"]
                  },
                  {
                      "type": "plugin",
                      "id": "mcp/playwright",
                      "allowed_tools": ["browser_navigate"]
                  }
              ],
              "context_length": 20000
          }
      )
      print(response.json())
  TypeScript:
    language: typescript
    code: |
      const response = await fetch("http://localhost:1234/api/v1/chat", {
        method: "POST",
        headers: {
          "Authorization": `Bearer ${process.env.LM_API_TOKEN}`,
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          model: "qwen/qwen3-4b-2507",
          input: "Find trending models using HF MCP and open the top one in my browser. Only open the top one, not the rest",
          integrations: [
            {
              type: "ephemeral_mcp",
              server_label: "huggingface",
              server_url: "https://huggingface.co/mcp",
              allowed_tools: ["model_search"]
            },
            {
              type: "plugin",
              id: "mcp/playwright",
              allowed_tools: ["browser_navigate"]
            }
          ],
          context_length: 20000
        })
      });
      const data = await response.json();
      console.log(data);
```

If `allowed_tools` is not provided, all tools from the server are available to the model.

## Custom headers for ephemeral servers

When using ephemeral MCP servers that require authentication, you can pass custom headers:

```lms_code_snippet
variants:
  curl:
    language: bash
    code: |
      curl http://localhost:1234/api/v1/chat \
        -H "Authorization: Bearer $LM_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "model": "qwen/qwen3-4b-2507",
          "input": "Search for something",
          "integrations": [
            {
              "type": "ephemeral_mcp",
              "server_label": "my-service",
              "server_url": "https://api.example.com/mcp",
              "headers": {
                "X-API-Key": "your-api-key"
              }
            }
          ]
        }'
  Python:
    language: python
    code: |
      import os
      import requests

      response = requests.post(
          "http://localhost:1234/api/v1/chat",
          headers={
              "Authorization": f"Bearer {os.environ['LM_API_TOKEN']}",
              "Content-Type": "application/json"
          },
          json={
              "model": "qwen/qwen3-4b-2507",
              "input": "Search for something",
              "integrations": [
                  {
                      "type": "ephemeral_mcp",
                      "server_label": "my-service",
                      "server_url": "https://api.example.com/mcp",
                      "headers": {
                          "X-API-Key": "your-api-key"
                      }
                  }
              ]
          }
      )
      print(response.json())
  TypeScript:
    language: typescript
    code: |
      const response = await fetch("http://localhost:1234/api/v1/chat", {
        method: "POST",
        headers: {
          "Authorization": `Bearer ${process.env.LM_API_TOKEN}`,
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          model: "qwen/qwen3-4b-2507",
          input: "Search for something",
          integrations: [
            {
              type: "ephemeral_mcp",
              server_label: "my-service",
              server_url: "https://api.example.com/mcp",
              headers: {
                "X-API-Key": "your-api-key"
              }
            }
          ]
        })
      });
      const data = await response.json();
      console.log(data);
```
