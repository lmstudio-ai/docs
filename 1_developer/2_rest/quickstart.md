---
title: Get up and running with the LM Studio API
sidebar_title: Quickstart
description: Download a model and start a simple Chat session using the REST API
fullPage: false
index: 2
---

## Start the server

[Install](/download) and launch LM Studio.

Then ensure the server is running through the toggle at the top left of the Developer page, or through [lms](/docs/cli) in the terminal:

```bash
lms server start
```

By default, the server is available at `http://127.0.0.1:1234`.

## Download a model

Use the download endpoint to download models by identifier from the [LM Studio model catalog](https://lmstudio.ai/models), or by Hugging Face model URL.

```lms_code_snippet
title: Download Qwen 3
variants:
  curl:
    language: bash
    code: |
      curl http://127.0.0.1:1234/api/v1/models/download \
        -H "Content-Type: application/json" \
        -d '{
          "model": "qwen/qwen3-4b-2507"
        }'
```

The response will return a `job_id` that you can use to track download progress. 

```lms_code_snippet
title: Track download
variants:
  curl:
    language: bash
    code: |
      curl \
        http://127.0.0.1:1234/api/v1/models/download/status/{job_id}
```

See the [download](/docs/developer/rest/download) and [download status](/docs/developer/rest/download-status) docs for more details.

## Chat with a model

Use the chat endpoint to send a message to a model. By default, the model will be automatically loaded if it is not already.

The `/api/v1/chat` endpoint is stateful, which means you do not need to pass the full history in every request. Read more about it [here](/docs/developer/rest/stateful-chats).

```lms_code_snippet
title: Simple chat
variants:
  curl:
    language: bash
    code: |
      curl http://127.0.0.1:1234/api/v1/chat \
        -H "Content-Type: application/json" \
        -d '{
          "model": "qwen/qwen3-4b-2507",
          "input": "Write a short haiku about sunrise."
        }'
```

See the full [chat](/docs/developer/rest/chat) docs for more details.

## Use MCP servers


Enable the model interact with remote Model Context Protocol (MCP) servers in `api/v1/chat` by specifying servers in the `remote_mcp_servers` field.

```lms_code_snippet
title: Use a remote MCP server
variants:
  curl:
    language: bash
    code: |
      curl http://127.0.0.1:1234/api/v1/chat \
        -H "Content-Type: application/json" \
        -d '{    
          "model": "qwen/qwen3-4b-2507",
          "input": "What is the top trending model on huggingface?",
          "remote_mcp_servers": [
            {                   
              "server_label": "huggingface", 
              "server_url": "https://huggingface.co/mcp",
              "allowed_tools": ["model_search"]
            }                    
          ]
        }'
```

You can also use locally configured MCP plugins (from your `mcp.json`) via the `plugins` field. Using locally run MCP plugins requires authentication via an API token passed through the `X-LM-API-Token` header. Read more about authentication [here](/docs/developer/core/authentication).

```lms_code_snippet
title: Use an MCP plugin
variants:
  curl:
    language: bash
    code: |
      curl http://127.0.0.1:1234/api/v1/chat \
        -H "Content-Type: application/json" \
        -H "X-LM-API-Token: $LM_API_TOKEN" \
        -d '{
          "model": "qwen/qwen3-4b-2507",
          "input": "Navigate to lmstudio.ai",
          "plugins": [
            {
              "id": "mcp/playwright",
              "allowed_tools": ["browser_navigate"]
            }
          ]
        }'
```

See the full [chat](/docs/developer/rest/chat) docs for more details.
