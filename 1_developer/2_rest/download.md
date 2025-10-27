---
title: "Download a model"
description: "Download models from the [model catalog](https://lmstudio.ai/models)"
fullPage: true
index: 5
api_info:
  method: POST
---

```lms_protip
This endpoint also allows you to download models from Hugging Face with specific quantization levels.
```

````lms_hstack
`POST /api/v1/models/download`

**Request body**
```lms_params
- name: model
  type: string
  optional: false
  description: The model to download.
- name: quantization
  type: string
  optional: true
  description: Specifies the quantization level for the hugging face model download. Example `Q4_K_M`.
```
:::split:::
```lms_code_snippet
title: Example Request
variants:
  curl:
    language: bash
    code: |
      curl http://127.0.0.1:1234/api/v1/models/download \
        -H "Authorization: Bearer $LM_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "model": "qwen/qwen3-4b-2507"
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
- name: bytes_per_second
  type: number
  optional: true
  description: Current download speed in bytes per second. Present when `status` is `downloading`.
- name: estimated_completion
  type: string
  optional: true
  description: Estimated completion time in ISO 8601 format. Present when `status` is `downloading`.
- name: completed_at
  type: string
  optional: true
  description: Download completion time in ISO 8601 format. Present when `status` is `completed`.
- name: total_size_bytes
  type: number
  optional: true
  description: Total size of the download in bytes. Absent when `status` is `already_downloaded`.
- name: downloaded_bytes
  type: number
  optional: true
  description: Number of bytes downloaded so far. Absent when `status` is `already_downloaded`.
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
        "downloaded_bytes": 948,
        "bytes_per_second": 7834.710743801653,
        "estimated_completion": "2025-10-07T00:21:47.030Z",
        "started_at": "2025-10-03T15:33:23.496Z"
      }
```
````
