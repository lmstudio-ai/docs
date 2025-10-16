---
title: Quickstart
sidebar_title: Quickstart
description: Get started with the LM Studio REST API.
fullPage: false
index: 2
---

### Start the server

[Install](/download) and launch LM Studio.

Then ensure the server is running through the toggle at the top left of the Developer page, or through [lms](/docs/cli) in the terminal:

```bash
lms server start
```

By default, the server is available at `http://127.0.0.1:1234`.

### Download a model

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

### Chat with a model

Use the chat endpoint to send a message to a model. By default, the model will be automatically loaded if it is not already.

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
