---
title: "Download a model"
description: "Download models from LM Studio Hub or Hugging Face"
---

## Download a model

Download a model from LM Studio Hub or Hugging Face. Supports model names from `lmstudio.ai/models`, `lmstudio.ai/models` URLs, and `huggingface.co` URLs with specifying quantizations.

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

---

````lms_hstack
**Response fields**

The response varies based on the download status.

```lms_params
- name: job_id
  type: string
  description: Unique identifier for the download job.
- name: status
  type: string
  description: Current status of the download. Possible values are `downloading`, `paused`, `completed`, `failed`, `already_downloaded`.
- name: items
  type: array
  description: Array of items being downloaded (model files and metadata).
- name: total_size_bytes
  type: number
  description: Total size of the download in bytes.
- name: downloaded_bytes
  type: number
  description: Number of bytes downloaded so far.
- name: bytes_per_second
  type: number
  optional: true
  description: Current download speed in bytes per second (when status is `downloading`).
- name: estimated_completion
  type: string
  optional: true
  description: Estimated completion time in ISO 8601 format (when status is `downloading`).
- name: started_at
  type: string
  optional: true
  description: Download start time in ISO 8601 format.
- name: completed_at
  type: string
  optional: true
  description: Download completion time in ISO 8601 format (when status is `completed`).
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

---

#### Item Structure

Each item in the `items` array represents a file being downloaded. If `type` is `model`, the item represents the actual model files being downloaded. If `type` is `model_yaml`, the item represents the [model.yaml](https://modelyaml.org/) and associated metadata.

```lms_params
- name: type
  type: string
  description: Type of the item (e.g., `model_yaml`, `model`).
- name: id
  type: string
  description: Unique identifier for the item.
- name: size_bytes
  type: number
  description: Size of the item in bytes.
- name: publisher
  type: string
  optional: true
  description: Publisher of the model (for model items).
- name: display_name
  type: string
  optional: true
  description: Human-readable name of the model (for model items).
- name: url
  type: string
  optional: true
  description: URL to the model page (for model items).
- name: quantization
  type: object
  optional: true
  description: Quantization information object (for model items).
- name: format
  type: string
  optional: true
  description: Model format (e.g., `mlx`) (for model items).
```
