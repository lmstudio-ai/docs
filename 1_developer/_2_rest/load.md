---
title: "Load a model"
description: "Load a llm or embedding into memory with custom configuration for inference"
fullPage: true
index: 4
api_info:
  method: POST
---
````lms_hstack
`POST /api/v1/models/load`

**Request body**
```lms_params
- name: model
  type: string
  optional: false
  description: Unique identifier for the model to load.
- name: config
  type: object
  optional: true
  description: Configuration for model loading parameters.
  children:
    - name: context_length
      type: number
      optional: true
      description: Maximum context length for the model in number of tokens.
    - name: eval_batch_size
      type: number
      optional: true
      description: Number of input tokens to process together in a single batch during evaluation. Absent for embedding models.
    - name: flash_attention
      type: boolean
      optional: true
      description: Whether Flash Attention is enabled for optimized attention computation. Absent for embedding models.
    - name: num_experts
      type: number
      optional: true
      description: Number of experts for MoE (Mixture of Experts) models. Absent for embedding models.
    - name: offload_kv_cache_to_gpu
      type: boolean
      optional: true
      description: Whether KV cache is offloaded to GPU memory. Absent for embedding models.
```
:::split:::
```lms_code_snippet
title: Example Request
variants:
  curl:
    language: bash
    code: |
      curl http://127.0.0.1:1234/api/v1/models/load \
        -H "Authorization: Bearer <YOUR_LM_API_TOKEN>" \
        -H "Content-Type: application/json" \
        -d '{
          "model": "openai/gpt-oss-20b",
          "config": {
            "context_length": 16384,
            "flash_attention": true
          }
        }'
```
````

---

````lms_hstack
**Response fields**
```lms_params
- name: model_instance_id
  type: string
  description: Unique identifier for the loaded model instance.
- name: config
  type: object
  description: Configuration used for loading the model.
  children:
    - name: context_length
      type: number
      optional: true
      description: Maximum context length for the model in number of tokens.
    - name: eval_batch_size
      type: number
      optional: true
      description: Number of input tokens to process together in a single batch during evaluation. Absent for embedding models.
    - name: flash_attention
      type: boolean
      optional: true
      description: Whether Flash Attention is enabled for optimized attention computation. Absent for embedding models.
    - name: num_experts
      type: number
      optional: true
      description: Number of experts for MoE (Mixture of Experts) models. Absent for embedding models.
    - name: offload_kv_cache_to_gpu
      type: boolean
      optional: true
      description: Whether KV cache is offloaded to GPU memory. Absent for embedding models.
- name: load_time_seconds
  type: number
  description: Time taken to load the model in seconds.
```
:::split:::
```lms_code_snippet
title: Response
variants:
  json:
    language: json
    code: |
      {
        "model_instance_id": "openai/gpt-oss-20b",
        "config": {
          "context_length": 16384,
          "eval_batch_size": 512,
          "flash_attention": true,
          "num_experts": 0,
          "offload_kv_cache_to_gpu": true
        },
        "load_time_seconds": 9.099
      }
```
````
