---
title: "List your models"
description: "Get a list of available models on your system, including both LLMs and embedding models."
fullPage: true
index: 6
api_info:
  method: GET
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
      curl http://localhost:1234/api/v1/models \
        -H "Authorization: Bearer $LM_API_TOKEN"
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
      description: Unique identifier for the model.
    - name: display_name
      type: string
      description: Human-readable model name.
    - name: architecture
      type: string | null
      optional: true
      description: Model architecture (e.g., "llama", "mistral"). Absent for embedding models.
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
      description: Size of the model in bytes.
    - name: params_string
      type: string | null
      description: Human-readable parameter count (e.g., "7B", "13B").
    - name: loaded_instances
      type: array
      description: List of currently loaded instances of this model.
      children:
        - name: id
          type: string
          description: Unique identifier for the loaded model instance.
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
              description: Number of input tokens to process together in a single batch during evaluation. Absent for embedding models.
            - name: parallel
              type: number
              optional: true
              description: Maximum number of parallel predictions the instance can handle. Absent for embedding models.
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
    - name: max_context_length
      type: number
      description: Maximum context length supported by the model in number of tokens.
    - name: format
      type: '"gguf" | "mlx" | null'
      description: Model file format.
    - name: capabilities
      type: object
      optional: true
      description: Model capabilities. Absent for embedding models.
      children:
        - name: vision
          type: boolean
          description: Whether the model supports vision/image inputs.
        - name: trained_for_tool_use
          type: boolean
          description: Whether the model was trained for tool/function calling.
        - name: reasoning
          type: object
          optional: true
          description: Public reasoning configuration for the model. Absent when no reasoning config is exposed.
          children:
            - name: allowed_options
              type: '("off" | "on" | "low" | "medium" | "high")[]'
              description: Allowed public reasoning settings for the model.
            - name: default
              type: '"off" | "on" | "low" | "medium" | "high"'
              description: Default public reasoning setting for the model.
    - name: description
      type: string | null
      optional: true
      description: Model description. Absent for embedding models.
    - name: variants
      type: array
      optional: true
      description: List of available quantization variant names for this model. Present for multi-variant models.
    - name: selected_variant
      type: string
      optional: true
      description: The currently selected variant name. Present when `variants` is present.
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
            "publisher": "google",
            "key": "google/gemma-4-26b-a4b",
            "display_name": "Gemma 4 26B A4B",
            "architecture": "gemma4",
            "quantization": {
              "name": "Q4_K_M",
              "bits_per_weight": 4
            },
            "size_bytes": 17990911801,
            "params_string": "26B-A4B",
            "loaded_instances": [
              {
                "id": "google/gemma-4-26b-a4b",
                "config": {
                  "context_length": 4096,
                  "eval_batch_size": 512,
                  "parallel": 4,
                  "flash_attention": true,
                  "num_experts": 8,
                  "offload_kv_cache_to_gpu": true
                }
              }
            ],
            "max_context_length": 262144,
            "format": "gguf",
            "capabilities": {
              "vision": true,
              "trained_for_tool_use": true,
              "reasoning": {
                "allowed_options": [
                  "off",
                  "on"
                ],
                "default": "on"
              }
            },
            "description": null,
            "variants": [
              "google/gemma-4-26b-a4b@q4_k_m"
            ],
            "selected_variant": "google/gemma-4-26b-a4b@q4_k_m"
          },
            {
              "type": "llm",
              "publisher": "deepseek",
              "key": "deepseek-r1",
              "display_name": "DeepSeek R1",
              "architecture": "deepseek",
              "quantization": {
                "name": "Q4_K_M",
                "bits_per_weight": 4
              },
              "size_bytes": 40492610355,
              "params_string": "671B",
              "loaded_instances": [],
              "max_context_length": 131072,
              "format": "gguf",
              "capabilities": {
                "vision": false,
                "trained_for_tool_use": true,
                "reasoning": {
                  "allowed_options": ["on"],
                  "default": "on"
                }
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
