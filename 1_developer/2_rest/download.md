---
title: "Download a model"
description: "Download LLMs and embedding models"
fullPage: true
index: 8
api_info:
  method: POST
---

````lms_hstack
`POST /api/v1/models/download`

**Request body**
```lms_params
- name: model
  type: string
  optional: false
  description: The model to download. Accepts [model catalog](https://lmstudio.ai/models) identifiers (e.g., `openai/gpt-oss-20b`) and exact Hugging Face links (e.g., `https://huggingface.co/lmstudio-community/gpt-oss-20b-GGUF`)
- name: quantization
  type: string
  optional: true
  description: Quantization level of the model to download (e.g., `Q4_K_M`). Only supported for Hugging Face links.
```
:::split:::
```lms_code_snippet
title: Example Request
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
```
````

````lms_hstack
**Response fields**

Returns a download job status object. The response varies based on the download status.

```lms_params
- name: job_id
  type: string
  optional: true
  description: Unique identifier for the download job. Absent when `status` is `already_downloaded`.
- name: status
  type: '"downloading" | "paused" | "completed" | "failed" | "already_downloaded"'
  description: Current status of the download.
- name: completed_at
  type: string
  optional: true
  description: Download completion time in ISO 8601 format. Present when `status` is `completed`.
- name: total_size_bytes
  type: number
  optional: true
  description: Total size of the download in bytes. Absent when `status` is `already_downloaded`.
- name: started_at
  type: string
  optional: true
  description: Download start time in ISO 8601 format. Absent when `status` is `already_downloaded`.
```
:::split:::
```lms_code_snippet
title: Response
variants:
  json:
    language: json
    code: |
      {
        "job_id": "job_493c7c9ded",
        "status": "downloading",
        "total_size_bytes": 2279145003,
        "started_at": "2025-10-03T15:33:23.496Z"
      }
```
````
