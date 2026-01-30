---
title: LM Studio API
sidebar_title: Overview
description: LM Studio's REST API for local inference and model management
fullPage: false
index: 1
---

LM Studio offers a powerful REST API with first-class support for local inference and model management. In addition to our native API, we provide OpenAI-compatible endpoints ([learn more](/docs/developer/openai-compat)) and Anthropic-compatible endpoints ([learn more](/docs/developer/anthropic-compat)).

## What's new
Previously, there was a [v0 REST API](/docs/developer/rest/endpoints). With LM Studio 0.4.0, we have officially released our native v1 REST API at `/api/v1/*` endpoints and recommend using it.

The v1 REST API includes enhanced features such as:
- [MCP via API](/docs/developer/core/mcp)
- [Stateful chats](/docs/developer/rest/stateful-chats)
- [Authentication](/docs/developer/core/authentication) configuration with API tokens
- Model [download](/docs/developer/rest/download), [load](/docs/developer/rest/load) and [unload](/docs/developer/rest/unload) endpoints

## Supported endpoints
The following endpoints are available in LM Studio's v1 REST API.
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
      <td><code>/api/v1/chat</code></td>
      <td><apimethod method="POST" /></td>
      <td><a href="/docs/developer/rest/chat">Chat</a></td>
    </tr>
    <tr>
      <td><code>/api/v1/models</code></td>
      <td><apimethod method="GET" /></td>
      <td><a href="/docs/developer/rest/list">List Models</a></td>
    </tr>
    <tr>
      <td><code>/api/v1/models/load</code></td>
      <td><apimethod method="POST" /></td>
      <td><a href="/docs/developer/rest/load">Load</a></td>
    </tr>
    <tr>
        <td><code>/api/v1/models/unload</code></td>
        <td><apimethod method="POST" /></td>
        <td><a href="/docs/developer/rest/unload">Unload</a></td>
    </tr>
    <tr>
      <td><code>/api/v1/models/download</code></td>
      <td><apimethod method="POST" /></td>
      <td><a href="/docs/developer/rest/download">Download</a></td>
    </tr>
    <tr>
      <td><code>/api/v1/models/download/status</code></td>
      <td><apimethod method="GET" /></td>
      <td><a href="/docs/developer/rest/download-status">Download Status</a></td>
    </tr>
  </tbody>
</table>

## Inference endpoint comparison
The table below compares the features of LM Studio's `/api/v1/chat` endpoint with OpenAI-compatible and Anthropic-compatible inference endpoints.
<table class="flexible-cols">
  <thead>
    <tr>
      <th>Feature</th>
      <th><a href="/docs/developer/rest/chat"><code>/api/v1/chat</code></a></th>
      <th><a href="/docs/developer/openai-compat/responses"><code>/v1/responses</code></a></th>
      <th><a href="/docs/developer/openai-compat/chat-completions"><code>/v1/chat/completions</code></a></th>
      <th><a href="/docs/developer/anthropic-compat/messages"><code>/v1/messages</code></a></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Streaming</td>
      <td>✅</td>
      <td>✅</td>
      <td>✅</td>
      <td>✅</td>
    </tr>
    <tr>
      <td>Stateful chat</td>
      <td>✅</td>
      <td>✅</td>
      <td>❌</td>
      <td>❌</td>
    </tr>
    <tr>
      <td>Remote MCPs</td>
      <td>✅</td>
      <td>✅</td>
      <td>❌</td>
      <td>❌</td>
    </tr>
    <tr>
      <td>MCPs you have in LM Studio</td>
      <td>✅</td>
      <td>✅</td>
      <td>❌</td>
      <td>❌</td>
    </tr>
    <tr>
      <td>Custom tools</td>
      <td>❌</td>
      <td>✅</td>
      <td>✅</td>
      <td>✅</td>
    </tr>
    <tr>
      <td>Include assistant messages in the request</td>
      <td>❌</td>
      <td>✅</td>
      <td>✅</td>
      <td>✅</td>
    </tr>
    <tr>
      <td>Model load streaming events</td>
      <td>✅</td>
      <td>❌</td>
      <td>❌</td>
      <td>❌</td>
    </tr>
    <tr>
      <td>Prompt processing streaming events</td>
      <td>✅</td>
      <td>❌</td>
      <td>❌</td>
      <td>❌</td>
    </tr>
    <tr>
      <td>Specify context length in the request</td>
      <td>✅</td>
      <td>❌</td>
      <td>❌</td>
      <td>❌</td>
    </tr>
  </tbody>
</table>

---

Please report bugs by opening an issue on [Github](https://github.com/lmstudio-ai/lmstudio-bug-tracker/issues).
