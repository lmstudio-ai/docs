---
title: "Download a model"
description: "Download models from LM Studio Hub or Hugging Face"
index: 5
---

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
  description: Unique identifier for the download job. Present for all statuses except `already_downloaded`.
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
  description: Total size of the download in bytes. Present for all statuses except `already_downloaded`.
- name: downloaded_bytes
  type: number
  optional: true
  description: Number of bytes downloaded so far. Present for all statuses except `already_downloaded`.
- name: items
  type: array
  optional: true
  description: Array of items being downloaded. Present for all statuses except `already_downloaded`.
  children:
    - name: type
      type: '"model" | "model_yaml"'
      description: Type of item being downloaded.
    - name: id
      type: string
      description: Unique identifier for the item.
    - name: size_bytes
      type: number
      description: Size of the item in bytes.
    - name: publisher
      type: string
      optional: true
      description: Model owner or repo owner for HF. Present when `type` is `model`.
    - name: display_name
      type: string
      optional: true
      description: Model display name. Present when `type` is `model`.
    - name: url
      type: string
      optional: true
      description: URL to the model page. Present when `type` is `model`.
    - name: quantization
      type: object | null
      optional: true
      description: Quantization information object. Present when `type` is `model`.
      children:
        - name: name
          type: string
          description: The quantization level (e.g., `4BIT`).
    - name: format
      type: string | null
      optional: true
      description: Model format (e.g., `mlx`). Present when `type` is `model`.
- name: started_at
  type: string
  optional: true
  description: Download start time in ISO 8601 format. Present for all statuses except `already_downloaded`.
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
        "items": [
          {
            "type": "model_yaml",
            "size_bytes": 171008,
            "id": "qwen/qwen3-4b-2507/model.yaml"
          },
          {
            "type": "model",
            "publisher": "qwen",
            "id": "qwen/qwen3-4b-2507",
            "display_name": "Qwen3 4B Instruct 2507",
            "url": "https://lmstudio.ai/models/qwen/qwen3-4b-2507",
            "size_bytes": 2279145003,
            "quantization": {
              "name": "4BIT"
            },
            "format": "mlx"
          }
        ],
        "bytes_per_second": 7834.710743801653,
        "estimated_completion": "2025-10-07T00:21:47.030Z",
        "started_at": "2025-10-03T15:33:23.496Z"
      }
```
````
