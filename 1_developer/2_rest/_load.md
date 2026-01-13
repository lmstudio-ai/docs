---
title: "Load a model"
description: "Load an LLM or Embedding model into memory with custom configuration for inference"
fullPage: true
index: 7
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
  description: Unique identifier of the model to load, either an LLM or an embedding model.
- name: context_length
  type: number
  optional: true
  description: Maximum number of tokens that the model will consider.
- name: eval_batch_size
  type: number
  optional: true
  description: Number of input tokens processed together in a single batch during evaluation. Applies only to LLMs loaded by LM Studio's [llama.cpp](https://github.com/ggml-org/llama.cpp)-based engine.
- name: flash_attention
  type: boolean
  optional: true
  description: Indicates whether attention computation is optimized to reduce memory usage and improve generation speed. Applies only to LLMs loaded by LM Studio's [llama.cpp](https://github.com/ggml-org/llama.cpp)-based engine.
- name: num_experts
  type: number
  optional: true
  description: Number of experts used during inference for MoE (Mixture of Experts) models. Applies only to MoE LLMs loaded by LM Studio's [llama.cpp](https://github.com/ggml-org/llama.cpp)-based engine.
- name: offload_kv_cache_to_gpu
  type: boolean
  optional: true
  description: Indicates if the KV cache is stored in GPU memory; if false, it is stored in CPU memory. Applies only to LLMs loaded by LM Studio's [llama.cpp](https://github.com/ggml-org/llama.cpp)-based engine.
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
      curl http://localhost:1234/api/v1/models/load \
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
      unstyledName: true
      type: object
      description: Configuration parameters specific to LLM models. `load_config` will be this type when `"type"` is `"llm"`. Only parameters relevant to the current model load are included.
      children:
        - name: context_length
          type: number
          optional: false
          description: Maximum number of tokens that the model will consider.
        - name: eval_batch_size
          type: number
          optional: true
          description: Number of input tokens processed together during evaluation. Present only for models loaded with LM Studio's [llama.cpp](https://github.com/ggml-org/llama.cpp)-based engine.
        - name: flash_attention
          type: boolean
          optional: true
          description: Indicates if Flash Attention is enabled for optimized attention computation. Present only for models loaded with LM Studio's [llama.cpp](https://github.com/ggml-org/llama.cpp)-based engine.
        - name: num_experts
          type: number
          optional: true
          description: Number of experts for Mixture of Experts (MoE) models. Present only for MoE models loaded with LM Studio's [llama.cpp](https://github.com/ggml-org/llama.cpp)-based engine.
        - name: offload_kv_cache_to_gpu
          type: boolean
          optional: true
          description: Indicates if the KV cache is stored in GPU memory. Present only for models loaded with LM Studio's [llama.cpp](https://github.com/ggml-org/llama.cpp)-based engine.
    - name: Embedding model load config
      unstyledName: true
      type: object
      description: Configuration parameters for embedding models. Present only when `"type"` is `"embedding"` and includes only the parameters used for loading.
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
