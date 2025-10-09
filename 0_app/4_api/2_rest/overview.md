---
title: LM Studio REST API
sidebar_title: Overview
index: 1
---

LM Studio offers a powerful REST API with first-class support for local model management and inference. In addition to our native API, we provide full OpenAI compatibility mode ([learn more](/docs/app/api/endpoints/openai)).

Our REST API handles local LLM workflows with model downloading, loading, configuration, and inference. Get performance stats like tokens per second, model status, context length, quantization info, and more. Configure loading parameters to customize how models initialize.

## Endpoints

- [`POST /api/v1/chat`](/docs/app/api/rest/chat) - Chat with a model
- [`GET /api/v1/models`](/docs/app/api/rest/list) - List your models
- [`POST /api/v1/models/load`](/docs/app/api/rest/load) - Load a model
- [`POST /api/v1/models/download`](/docs/app/api/rest/download) - Download a model
- [`GET /api/v1/models/download/status`](/docs/app/api/rest/download-status) - Get download status

---

Please report bugs by opening an issue on [Github](https://github.com/lmstudio-ai/lmstudio-bug-tracker/issues).
