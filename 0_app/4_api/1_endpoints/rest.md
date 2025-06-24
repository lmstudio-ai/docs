---
title: LM Studio REST API (beta)
description: "The REST API includes enhanced stats such as Token / Second and Time To First Token (TTFT), as well as rich information about models such as loaded vs unloaded, max context, quantization, and more."
---

`Experimental`

##### Requires [LM Studio 0.3.6](/download) or newer. Still WIP, endpoints may change.

LM Studio now has its own REST API, in addition to OpenAI compatibility mode ([learn more](/docs/app/api/endpoints/openai)).

The REST API includes enhanced stats such as Token / Second and Time To First Token (TTFT), as well as rich information about models such as loaded vs unloaded, max context, quantization, and more.

#### Supported API Endpoints

- [`GET /api/v0/models`](#get-apiv0models) - List available models
- [`GET /api/v0/models/{model}`](#get-apiv0modelsmodel) - Get info about a specific model
- [`POST /api/v0/chat/completions`](#post-apiv0chatcompletions) - Chat Completions (messages -> assistant response)
- [`POST /api/v0/completions`](#post-apiv0completions) - Text Completions (prompt -> completion)
- [`POST /api/v0/embeddings`](#post-apiv0embeddings) - Text Embeddings (text -> embedding)

###### 🚧 We are in the process of developing this interface. Let us know what's important to you on [Github](https://github.com/lmstudio-ai/lmstudio.js/issues) or by [email](mailto:bugs@lmstudio.ai).

---

### Start the REST API server

To start the server, run the following command:

```bash
lms server start
```

```lms_protip
You can run LM Studio as a service and get the server to auto-start on boot without launching the GUI. [Learn about Headless Mode](/docs/advanced/headless).
```

## Endpoints

### `GET /api/v0/models`

List all loaded and downloaded models

**Example request**

```bash
curl http://localhost:1234/api/v0/models
```

**Response format**

```json
{
  "object": "list",
  "data": [
    {
      "id": "qwen2-vl-7b-instruct",
      "object": "model",
      "type": "vlm",
      "publisher": "mlx-community",
      "arch": "qwen2_vl",
      "compatibility_type": "mlx",
      "quantization": "4bit",
      "state": "not-loaded",
      "max_context_length": 32768
    },
    {
      "id": "meta-llama-3.1-8b-instruct",
      "object": "model",
      "type": "llm",
      "publisher": "lmstudio-community",
      "arch": "llama",
      "compatibility_type": "gguf",
      "quantization": "Q4_K_M",
      "state": "not-loaded",
      "max_context_length": 131072
    },
    {
      "id": "text-embedding-nomic-embed-text-v1.5",
      "object": "model",
      "type": "embeddings",
      "publisher": "nomic-ai",
      "arch": "nomic-bert",
      "compatibility_type": "gguf",
      "quantization": "Q4_0",
      "state": "not-loaded",
      "max_context_length": 2048
    }
  ]
}
```

---

### `GET /api/v0/models/{model}`

Get info about one specific model

**Example request**

```bash
curl http://localhost:1234/api/v0/models/qwen2-vl-7b-instruct
```

**Response format**

```json
{
  "id": "qwen2-vl-7b-instruct",
  "object": "model",
  "type": "vlm",
  "publisher": "mlx-community",
  "arch": "qwen2_vl",
  "compatibility_type": "mlx",
  "quantization": "4bit",
  "state": "not-loaded",
  "max_context_length": 32768
}
```

---

### `POST /api/v0/chat/completions`

Chat Completions API. You provide a messages array and receive the next assistant response in the chat.

**Example request**

```bash
curl http://localhost:1234/api/v0/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "granite-3.0-2b-instruct",
    "messages": [
      { "role": "system", "content": "Always answer in rhymes." },
      { "role": "user", "content": "Introduce yourself." }
    ],
    "temperature": 0.7,
    "max_tokens": -1,
    "stream": false
  }'
```

**Response format**

```json
{
  "id": "chatcmpl-i3gkjwthhw96whukek9tz",
  "object": "chat.completion",
  "created": 1731990317,
  "model": "granite-3.0-2b-instruct",
  "choices": [
    {
      "index": 0,
      "logprobs": null,
      "finish_reason": "stop",
      "message": {
        "role": "assistant",
        "content": "Greetings, I'm a helpful AI, here to assist,\nIn providing answers, with no distress.\nI'll keep it short and sweet, in rhyme you'll find,\nA friendly companion, all day long you'll bind."
      }
    }
  ],
  "usage": {
    "prompt_tokens": 24,
    "completion_tokens": 53,
    "total_tokens": 77
  },
  "stats": {
    "tokens_per_second": 51.43709529007664,
    "time_to_first_token": 0.111,
    "generation_time": 0.954,
    "stop_reason": "eosFound"
  },
  "model_info": {
    "arch": "granite",
    "quant": "Q4_K_M",
    "format": "gguf",
    "context_length": 4096
  },
  "runtime": {
    "name": "llama.cpp-mac-arm64-apple-metal-advsimd",
    "version": "1.3.0",
    "supported_formats": ["gguf"]
  }
}
```

---

### `POST /api/v0/completions`

Text Completions API. You provide a prompt and receive a completion.

**Example request**

```bash
curl http://localhost:1234/api/v0/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "granite-3.0-2b-instruct",
    "prompt": "the meaning of life is",
    "temperature": 0.7,
    "max_tokens": 10,
    "stream": false,
    "stop": "\n"
  }'
```

**Response format**

```json
{
  "id": "cmpl-p9rtxv6fky2v9k8jrd8cc",
  "object": "text_completion",
  "created": 1731990488,
  "model": "granite-3.0-2b-instruct",
  "choices": [
    {
      "index": 0,
      "text": " to find your purpose, and once you have",
      "logprobs": null,
      "finish_reason": "length"
    }
  ],
  "usage": {
    "prompt_tokens": 5,
    "completion_tokens": 9,
    "total_tokens": 14
  },
  "stats": {
    "tokens_per_second": 57.69230769230769,
    "time_to_first_token": 0.299,
    "generation_time": 0.156,
    "stop_reason": "maxPredictedTokensReached"
  },
  "model_info": {
    "arch": "granite",
    "quant": "Q4_K_M",
    "format": "gguf",
    "context_length": 4096
  },
  "runtime": {
    "name": "llama.cpp-mac-arm64-apple-metal-advsimd",
    "version": "1.3.0",
    "supported_formats": ["gguf"]
  }
}
```

---

### `POST /api/v0/embeddings`

Text Embeddings API. You provide a text and a representation of the text as an embedding vector is returned.

**Example request**

```bash
curl http://127.0.0.1:1234/api/v0/embeddings \
  -H "Content-Type: application/json" \
  -d '{
    "model": "text-embedding-nomic-embed-text-v1.5",
    "input": "Some text to embed"
  }
```

**Example response**

```json
{
  "object": "list",
  "data": [
    {
      "object": "embedding",
      "embedding": [
        -0.016731496900320053,
        0.028460891917347908,
        -0.1407836228609085,
        ... (truncated for brevity) ...,
        0.02505224384367466,
        -0.0037634256295859814,
        -0.04341062530875206
      ],
      "index": 0
    }
  ],
  "model": "text-embedding-nomic-embed-text-v1.5@q4_k_m",
  "usage": {
    "prompt_tokens": 0,
    "total_tokens": 0
  }
}
```

---

Please report bugs by opening an issue on [Github](https://github.com/lmstudio-ai/lmstudio-bug-tracker/issues).
