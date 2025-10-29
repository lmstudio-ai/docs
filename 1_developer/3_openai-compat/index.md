---
title: OpenAI Compatibility Endpoints
sidebar_title: Overview
description: Send requests to Responses, Chat Completions (text and images), Completions, and Embeddings endpoints.
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
      <td><code>/v1/models</code></td>
      <td><apimethod method="GET" /></td>
      <td><a href="/docs/developer/openai-compat/models">Models</a></td>
    </tr>
    <tr>
      <td><code>/v1/responses</code></td>
      <td><apimethod method="POST" /></td>
      <td><a href="/docs/developer/openai-compat/responses">Responses</a></td>
    </tr>
    <tr>
      <td><code>/v1/chat/completions</code></td>
      <td><apimethod method="POST" /></td>
      <td><a href="/docs/developer/openai-compat/chat-completions">Chat Completions</a></td>
    </tr>
    <tr>
      <td><code>/v1/embeddings</code></td>
      <td><apimethod method="POST" /></td>
      <td><a href="/docs/developer/openai-compat/embeddings">Embeddings</a></td>
    </tr>
    <tr>
      <td><code>/v1/completions</code></td>
      <td><apimethod method="POST" /></td>
      <td><a href="/docs/developer/openai-compat/completions">Completions</a></td>
    </tr>
  </tbody>
</table>

<hr>

## Set the `base url` to point to LM Studio

You can reuse existing OpenAI clients (in Python, JS, C#, etc) by switching up the "base URL" property to point to your LM Studio instead of OpenAI's servers.

Note: The following examples assume the server port is `1234`

### Python Example

```diff
from openai import OpenAI

client = OpenAI(
+    base_url="http://localhost:1234/v1"
)

# ... the rest of your code ...
```

### Typescript Example

```diff
import OpenAI from 'openai';

const client = new OpenAI({
+  baseUrl: "http://localhost:1234/v1"
});

// ... the rest of your code ...
```

### cURL Example

```diff
- curl https://api.openai.com/v1/chat/completions \
+ curl http://localhost:1234/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
-     "model": "gpt-4o-mini",
+     "model": "use the model identifier from LM Studio here",
     "messages": [{"role": "user", "content": "Say this is a test!"}],
     "temperature": 0.7
   }'
```

---

Other OpenAI client libraries should have similar options to set the base URL.

If you're running into trouble, hop onto our [Discord](https://discord.gg/lmstudio) and enter the `#🔨-developers` channel.
