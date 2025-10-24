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
  description: Unique identifier for the model to load. Can be an LLM or embedding model.
- name: context_length
  type: number
  optional: true
  description: Maximum number of tokens that the model will consider.
- name: eval_batch_size
  type: number
  optional: true
  description: Number of input tokens to process together in a single batch during evaluation. LLM only.
- name: flash_attention
  type: boolean
  optional: true
  description: Whether Flash Attention is enabled for optimized attention computation. Can decrease memory usage and improved generation speed. LLM only.
- name: num_experts
  type: number
  optional: true
  description: Number of expert to use during inference for MoE (Mixture of Experts) models. Has no effect on non-MoE models. LLM only.
- name: offload_kv_cache_to_gpu
  type: boolean
  optional: true
  description: LLM only. Whether KV cache is offloaded to GPU memory. If false, KV cache is stored in CPU memory/RAM. LLM only.
- name: echo_load_config
  type: boolean
  optional: true
  description: If true, echoes the final load configuration in the response under `"load_config"`. Default `false`.
```
:::split:::
```lms_code_snippet
title: Example Request
variants:
  curl:
    language: bash
    code: |
      curl http://127.0.0.1:1234/api/v1/models/load \
        -H "Authorization: Bearer $LM_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "model": "openai/gpt-oss-20b",
          "context_length": 16384,
          "flash_attention": true,
          "echo_load_config": true,
        }'
```
````

---

````lms_hstack
**Response fields**
```lms_params
- name: type
  type: '"llm" | "embedding"'
  description: Type of the loaded model.
- name: model_instance_id
  type: string
  description: Unique identifier for the loaded model instance.
- name: load_time_seconds
  type: number
  description: Time taken to load the model in seconds.
- name: status
  type: '"loaded"'
  description: Load status.
- name: load_config
  type: object
  optional: true
  description: The final configuration applied to the loaded model. This may include settings that were not specified in the request. Included only when `"echo_load_config"` is `true` in the request.
  children:
    - name: LLM load config
      type: object
      description: Configuration parameters specific to LLM models. `load_config` will be this type when `"type"` is `"llm"`. Only parameters that applied to the load will be present.
      children:
        - name: context_length
          type: number
          optional: false
          description: Maximum number of tokens that the model will consider.
        - name: eval_batch_size
          type: number
          optional: true
          description: Number of input tokens to process together in a single batch during evaluation.
        - name: flash_attention
          type: boolean
          optional: true
          description: Whether Flash Attention is enabled for optimized attention computation.
        - name: num_experts
          type: number
          optional: true
          description: Number of experts for MoE (Mixture of Experts) models.
        - name: offload_kv_cache_to_gpu
          type: boolean
          optional: true
          description: Whether KV cache is offloaded to GPU memory.
    - name: Embedding model load config
      type: object
      description: Configuration parameters specific to embedding models. `load_config` will be this type when `"type"` is `"embedding"`. Only parameters that applied to the load will be present.
      children:
        - name: context_length
          type: number
          optional: false
          description: Maximum number of tokens that the model will consider.
```
:::split:::
```lms_code_snippet
title: Response
variants:
  json:
    language: json
    code: |
      {
        "type": "llm",
        "model_instance_id": "openai/gpt-oss-20b",
        "load_time_seconds": 9.099,
        "status": "loaded",
        "load_config": {
          "context_length": 16384,
          "eval_batch_size": 512,
          "flash_attention": true,
          "offload_kv_cache_to_gpu": true,
          "num_experts": 4
        }
      }
```
````
