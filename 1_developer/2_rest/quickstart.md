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

By default, the server is available at `http://localhost:1234`.

If you don't have a model downloaded yet, you can download the model:

```bash
lms get ibm/granite-4-micro
```


## API Authentication

By default, the LM Studio API server does **not** require authentication. You can configure the server to require authentication by API token in the [server settings](/docs/developer/core/server/settings) for added security.

To authenticate API requests, generate an API token from the Developer page in LM Studio, and include it in the `Authorization` header of your requests as follows: `Authorization: Bearer $LM_API_TOKEN`. Read more about authentication [here](/docs/developer/core/authentication).


## Chat with a model

Use the chat endpoint to send a message to a model. By default, the model will be automatically loaded if it is not already.

The `/api/v1/chat` endpoint is stateful, which means you do not need to pass the full history in every request. Read more about it [here](/docs/developer/rest/stateful-chats).

```lms_code_snippet
variants:
  curl:
    language: bash
    code: |
      curl http://localhost:1234/api/v1/chat \
        -H "Authorization: Bearer $LM_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "model": "ibm/granite-4-micro",
          "input": "Write a short haiku about sunrise."
        }'
  Python:
    language: python
    code: |
      import os
      import requests
      import json

      response = requests.post(
        "http://localhost:1234/api/v1/chat",
        headers={
          "Authorization": f"Bearer {os.environ['LM_API_TOKEN']}",
          "Content-Type": "application/json"
        },
        json={
          "model": "ibm/granite-4-micro",
          "input": "Write a short haiku about sunrise."
        }
      )
      print(json.dumps(response.json(), indent=2))
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
          model: "ibm/granite-4-micro",
          input: "Write a short haiku about sunrise."
        })
      });
      const data = await response.json();
      console.log(data);
```

See the full [chat](/docs/developer/rest/chat) docs for more details.

## Use MCP servers via API


Enable the model interact with ephemeral Model Context Protocol (MCP) servers in `/api/v1/chat` by specifying servers in the `integrations` field.

```lms_code_snippet
variants:
  curl:
    language: bash
    code: |
      curl http://localhost:1234/api/v1/chat \
        -H "Authorization: Bearer $LM_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "model": "ibm/granite-4-micro",
          "input": "What is the top trending model on hugging face?",
          "integrations": [
            {
              "type": "ephemeral_mcp",
              "server_label": "huggingface",
              "server_url": "https://huggingface.co/mcp",
              "allowed_tools": ["model_search"]
            }
          ],
          "context_length": 8000
        }'
  Python:
    language: python
    code: |
      import os
      import requests
      import json

      response = requests.post(
        "http://localhost:1234/api/v1/chat",
        headers={
          "Authorization": f"Bearer {os.environ['LM_API_TOKEN']}",
          "Content-Type": "application/json"
        },
        json={
          "model": "ibm/granite-4-micro",
          "input": "What is the top trending model on hugging face?",
          "integrations": [
            {
              "type": "ephemeral_mcp",
              "server_label": "huggingface",
              "server_url": "https://huggingface.co/mcp",
              "allowed_tools": ["model_search"]
            }
          ],
          "context_length": 8000
        }
      )
      print(json.dumps(response.json(), indent=2))
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
          model: "ibm/granite-4-micro",
          input: "What is the top trending model on hugging face?",
          integrations: [
            {
              type: "ephemeral_mcp",
              server_label: "huggingface",
              server_url: "https://huggingface.co/mcp",
              allowed_tools: ["model_search"]
            }
          ],
          context_length: 8000
        })
      const data = await response.json();
      console.log(data);
```

You can also use locally configured MCP plugins (from your `mcp.json`) via the `integrations` field. Using locally run MCP plugins requires authentication via an API token passed through the `Authorization` header. Read more about authentication [here](/docs/developer/core/authentication).

```lms_code_snippet
variants:
  curl:
    language: bash
    code: |
      curl http://localhost:1234/api/v1/chat \
        -H "Authorization: Bearer $LM_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "model": "ibm/granite-4-micro",
          "input": "Open lmstudio.ai",
          "integrations": [
            {
              "type": "plugin",
              "id": "mcp/playwright",
              "allowed_tools": ["browser_navigate"]
            }
          ],
          "context_length": 8000
        }'
  Python:
    language: python
    code: |
      import os
      import requests
      import json

      response = requests.post(
        "http://localhost:1234/api/v1/chat",
        headers={
          "Authorization": f"Bearer {os.environ['LM_API_TOKEN']}",
          "Content-Type": "application/json"
        },
        json={
          "model": "ibm/granite-4-micro",
          "input": "Open lmstudio.ai",
          "integrations": [
            {
              "type": "plugin",
              "id": "mcp/playwright",
              "allowed_tools": ["browser_navigate"]
            }
          ],
          "context_length": 8000
        }
      )
      print(json.dumps(response.json(), indent=2))
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
          model: "ibm/granite-4-micro",
          input: "Open lmstudio.ai",
          integrations: [
            {
              type: "plugin",
              id: "mcp/playwright",
              allowed_tools: ["browser_navigate"]
            }
          ],
          context_length: 8000
        })
      });
      const data = await response.json();
      console.log(data);
```

See the full [chat](/docs/developer/rest/chat) docs for more details.

## Download a model

Use the download endpoint to download models by identifier from the [LM Studio model catalog](https://lmstudio.ai/models), or by Hugging Face model URL.

```lms_code_snippet
variants:
  curl:
    language: bash
    code: |
      curl http://localhost:1234/api/v1/models/download \
        -H "Authorization: Bearer $LM_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "model": "ibm/granite-4-micro"
        }'
  Python:
    language: python
    code: |
      import os
      import requests
      import json

      response = requests.post(
        "http://localhost:1234/api/v1/models/download",
        headers={
          "Authorization": f"Bearer {os.environ['LM_API_TOKEN']}",
          "Content-Type": "application/json"
        },
        json={"model": "ibm/granite-4-micro"}
      )
      print(json.dumps(response.json(), indent=2))
  TypeScript:
    language: typescript
    code: |
      const response = await fetch("http://localhost:1234/api/v1/models/download", {
        method: "POST",
        headers: {
          "Authorization": `Bearer ${process.env.LM_API_TOKEN}`,
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          model: "ibm/granite-4-micro"
        })
      });
      const data = await response.json();
      console.log(data);
```

The response will return a `job_id` that you can use to track download progress.

```lms_code_snippet
variants:
  curl:
    language: bash
    code: |
      curl -H "Authorization: Bearer $LM_API_TOKEN" \
        http://localhost:1234/api/v1/models/download/status/{job_id}
  Python:
    language: python
    code: |
      import os
      import requests
      import json

      job_id = "your-job-id"
      response = requests.get(
        f"http://localhost:1234/api/v1/models/download/status/{job_id}",
        headers={"Authorization": f"Bearer {os.environ['LM_API_TOKEN']}"}
      )
      print(json.dumps(response.json(), indent=2))
  TypeScript:
    language: typescript
    code: |
      const jobId = "your-job-id";
      const response = await fetch(
        `http://localhost:1234/api/v1/models/download/status/${jobId}`,
        {
          headers: {
            "Authorization": `Bearer ${process.env.LM_API_TOKEN}`
          }
        }
      );
      const data = await response.json();
      console.log(data);
```

See the [download](/docs/developer/rest/download) and [download status](/docs/developer/rest/download-status) docs for more details.
