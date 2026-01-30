---
title: Anthropic Compatibility Endpoints
sidebar_title: Overview
description: Send Messages requests using the Anthropic-compatible API.
index: 1
---

### Supported endpoints

<table class="flexible-cols">
  <thead>
    <tr>
      <th>Endpoint</th>
      <th>Method</th>
      <th>Docs</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>/v1/messages</code></td>
      <td><apimethod method="POST" /></td>
      <td><a href="/docs/developer/anthropic-compat/messages">Messages</a></td>
    </tr>
  </tbody>
</table>

<hr>

## Using Claude Code with LM Studio

For a full walkthrough, see: [Use Claude Code with LM Studio](/docs/integrations/claude-code).

```bash
export ANTHROPIC_BASE_URL=http://localhost:1234
export ANTHROPIC_AUTH_TOKEN=lmstudio
claude --model openai/gpt-oss-20b
```

## Authentication headers

When Require Authentication is enabled, LM Studio accepts both `x-api-token` and the standard `Authorization: Bearer <token>` header. To learn more about enabling auth in LM Studio, checkout [Authentication](/docs/developer/core/authentication).

## Set the base URL to point to LM Studio

Point your Anthropic client (or any HTTP request) at your local LM Studio server.

Note: The following examples assume the server port is `1234`.

### cURL example

```diff
- curl https://api.anthropic.com/v1/messages \
+ curl http://localhost:1234/v1/messages \
   -H "Content-Type: application/json" \
+  -H "x-api-key: $LM_API_TOKEN" \
   -d '{
-    "model": "claude-4-5-sonnet",
+    "model": "ibm/granite-4-micro",
     "max_tokens": 256,
     "messages": [
       {"role": "user", "content": "Write a haiku about local LLMs."}
     ]
   }'
```

### Python example

```python
from anthropic import Anthropic

client = Anthropic(
    base_url="http://localhost:1234",
    api_key="lmstudio",
)

message = client.messages.create(
    max_tokens=1024,
    messages=[
        {
            "role": "user",
            "content": "Hello from LM Studio",
        }
    ],
    model="ibm/granite-4-micro",
)

print(message.content)
```

If you have not enabled Require Authentication, the `x-api-key` header is optional.
For the Python example, you can also omit `api_key` when authentication is disabled.


If you're running into trouble, hop onto our [Discord](https://discord.gg/lmstudio) and enter the developers channel.
