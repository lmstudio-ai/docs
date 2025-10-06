---
title: "Load a model"
description: "Load a model into memory with custom configuration for inference"
---
## Load a model

Load a model into memory with custom configuration for inference.

````lms_hstack
`POST /api/v1/models/load`

**Request body**
```lms_params
- name: model
  type: string
  optional: false
  description: The identifier of the model to load (e.g., "openai/gpt-oss-20b").
- name: config
  type: object
  optional: true
  description: Optional configuration object for model loading parameters.
  children:
    - name: context_length
      type: number
      optional: true
      description: Specifies the maximum context length for the model in number of tokens. If not provided, uses the model's default context length.
    - name: eval_batch_size
      type: number
      optional: true
      description: Number of input tokens to process together in a single batch during evaluation. Increasing this value typically improves processing speed and throughput by leveraging parallelization, but requires more memory. Finding the optimal batch size often involves balancing between performance gains and available hardware resources.
    - name: flash_attention
      type: boolean
      optional: true
      description: Enables Flash Attention for optimized attention computation.
    - name: num_experts
      type: number
      optional: true
      description: Specifies the number of experts for MoE (Mixture of Experts) models.
    - name: offload_kv_cache_to_gpu
      type: boolean
      optional: true
      description: Determines whether to offload KV cache to GPU memory.
```
:::split:::
```lms_code_snippet
title: Example Request
variants:
  curl:
    language: bash
    code: |
      curl http://127.0.0.1:1234/api/v1/models/load \
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
  description: The unique identifier for the loaded model instance.
- name: config
  type: object
  description: The actual configuration used for loading the model (includes defaults).
  children:
    - name: context_length
      type: number
      description: The maximum context length for the model in number of tokens.
    - name: eval_batch_size
      type: number
      description: Number of input tokens to process together in a single batch during evaluation.
    - name: flash_attention
      type: boolean
      description: Whether Flash Attention is enabled for optimized attention computation.
    - name: num_experts
      type: number
      description: The number of experts for MoE (Mixture of Experts) models.
    - name: offload_kv_cache_to_gpu
      type: boolean
      description: Whether KV cache is offloaded to GPU memory.
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


