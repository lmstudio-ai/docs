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

| Endpoint                         | Method                          | Docs                                             |
| -------------------------------- | ------------------------------- | ------------------------------------------------ |
| `/api/v1/chat`                   | <apimethod method="POST" />     | [Chat](/docs/developer/rest/chat)               |
| `/api/v1/models`                 | <apimethod method="GET" />      | [List Models](/docs/developer/rest/list)        |
| `/api/v1/models/load`            | <apimethod method="POST" />     | [Load](/docs/developer/rest/load)               |
| `/api/v1/models/download`        | <apimethod method="POST" />     | [Download](/docs/developer/rest/download)       |
| `/api/v1/models/download/status` | <apimethod method="GET" />      | [Download Status](/docs/developer/rest/download-status) |

---

Please report bugs by opening an issue on [Github](https://github.com/lmstudio-ai/lmstudio-bug-tracker/issues).
