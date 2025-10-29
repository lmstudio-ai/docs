---
title: LM Studio API
sidebar_title: Overview
description: Get started with LM Studio's REST API for local model management and inference.
fullPage: true
index: 1
---

LM Studio offers a powerful REST API with first-class support for local model management and inference. In addition to our native API, we provide full OpenAI compatibility mode ([learn more](/docs/developer/openai-compat)).

Our REST API handles local LLM workflows with model downloading, loading, configuration, and inference. Get performance stats like tokens per second, model status, context length, quantization info, and more. Configure loading parameters to customize how models initialize.

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

---

Please report bugs by opening an issue on [Github](https://github.com/lmstudio-ai/lmstudio-bug-tracker/issues).
