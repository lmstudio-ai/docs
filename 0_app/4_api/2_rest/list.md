---
title: "List your models"
description: "Get a list of available models on your system, including both LLMs and embedding models."
index: 3
---

````lms_hstack
`GET /api/v1/models`

This endpoint has no request parameters.
:::split:::
```lms_code_snippet
title: Example Request
variants:
  curl:
    language: bash
    code: |
      curl http://127.0.0.1:1234/api/v1/models
```
````

---

````lms_hstack
**Response fields**
```lms_params
- name: models
  type: array
  description: List of available models (both LLMs and embedding models).
  children:
    - name: type
      type: '"llm" | "embedding"'
      description: Type of model.
    - name: publisher
      type: string
      description: Model publisher name.
    - name: key
      type: string
      description: Unique model key identifier.
    - name: display_name
      type: string
      description: Human-readable model name.
    - name: architecture
      type: string | null
      optional: true
      description: Model architecture (e.g., "llama", "mistral"). Only present for type `llm`.
    - name: quantization
      type: object | null
      description: Quantization information for the model.
      children:
        - name: name
          type: string | null
          description: Quantization method name.
        - name: bits_per_weight
          type: number | null
          description: Bits per weight for the quantization.
    - name: size_bytes
      type: number
      description: Model size in bytes.
    - name: params_string
      type: string | null
      description: Human-readable parameter count (e.g., "7B", "13B").
    - name: loaded_instances
      type: array
      description: List of currently loaded instances of this model.
      children:
        - name: id
          type: string
          description: Unique identifier for the loaded instance.
        - name: config
          type: object
          description: Configuration for the loaded instance.
          children:
            - name: context_length
              type: number
              description: The maximum context length for the model in number of tokens.
            - name: eval_batch_size
              type: number
              optional: true
              description: Number of input tokens to process together in a single batch during evaluation. Only present for type `llm`.
            - name: flash_attention
              type: boolean
              optional: true
              description: Whether Flash Attention is enabled for optimized attention computation. Only present for type `llm`.
            - name: num_experts
              type: number
              optional: true
              description: The number of experts for MoE (Mixture of Experts) models. Only present for type `llm`.
            - name: offload_kv_cache_to_gpu
              type: boolean
              optional: true
              description: Whether KV cache is offloaded to GPU memory. Only present for type `llm`.
    - name: max_context_length
      type: number
      description: Maximum context length supported by the model.
    - name: format
      type: '"gguf" | "mlx" | null'
      description: Model file format.
    - name: capabilities
      type: object
      optional: true
      description: Model capabilities. Only present for type `llm`.
      children:
        - name: vision
          type: boolean
          description: Whether the model supports vision/image inputs.
        - name: trained_for_tool_use
          type: boolean
          description: Whether the model was trained for tool/function calling.
    - name: description
      type: string | null
      optional: true
      description: Model description. Only present for type `llm`.
```
:::split:::
```lms_code_snippet
title: Response
variants:
  json:
    language: json
    code: |
      {
        "models": [
          {
            "type": "llm",
            "publisher": "lmstudio-community",
            "key": "gemma-3-270m-it-qat",
            "display_name": "Gemma 3 270m Instruct Qat",
            "architecture": "gemma3",
            "quantization": {
              "name": "Q4_0",
              "bits_per_weight": 4
            },
            "size_bytes": 241410208,
            "params_string": "270M",
            "loaded_instances": [
              {
                "id": "gemma-3-270m-it-qat",
                "config": {
                  "context_length": 4096
                }
              }
            ],
            "max_context_length": 32768,
            "format": "gguf",
            "capabilities": {
              "vision": false,
              "trained_for_tool_use": false
            },
            "description": null
          },
          {
            "type": "embedding",
            "publisher": "gaianet",
            "key": "text-embedding-nomic-embed-text-v1.5-embedding",
            "display_name": "Nomic Embed Text v1.5",
            "quantization": {
              "name": "F16",
              "bits_per_weight": 16
            },
            "size_bytes": 274290560,
            "params_string": null,
            "loaded_instances": [],
            "max_context_length": 2048,
            "format": "gguf"
          }
        ]
      }
```
````
