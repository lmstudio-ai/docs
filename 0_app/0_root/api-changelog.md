---
title: API Changelog
description: LM Studio API Changelog - new features and updates
index: 2
---

###### [👾 LM Studio 0.3.15](/blog/lmstudio-v0.3.15) • 2025-04-24

### Improved Tool Use API Support

OpenAI-like REST API now supports the `tool_choice` parameter:

```json
{
  "tool_choice": "auto" // or "none", "required"
}
```

- `"tool_choice": "none"` — Model will not call tools
- `"tool_choice": "auto"` — Model decides
- `"tool_choice": "required"` — Model must call tools (llama.cpp only)

Chunked responses now set `"finish_reason": "tool_calls"` when appropriate.

---

###### [👾 LM Studio 0.3.14](/blog/lmstudio-v0.3.14) • 2025-03-27

### [API/SDK] Preset Support

RESTful API and SDKs support specifying presets in requests.

_(example needed)_

###### [👾 LM Studio 0.3.10](/blog/lmstudio-v0.3.10) • 2025-02-18

### Speculative Decoding API

Enable speculative decoding in API requests with `"draft_model"`:

```json
{
  "model": "deepseek-r1-distill-qwen-7b",
  "draft_model": "deepseek-r1-distill-qwen-0.5b",
  "messages": [ ... ]
}
```

Responses now include a `stats` object for speculative decoding:

```json
"stats": {
  "tokens_per_second": ...,
  "draft_model": "...",
  "total_draft_tokens_count": ...,
  "accepted_draft_tokens_count": ...,
  "rejected_draft_tokens_count": ...,
  "ignored_draft_tokens_count": ...
}
```

---

###### [👾 LM Studio 0.3.9](/blog/lmstudio-v0.3.9) • 2025-01-30

### Idle TTL and Auto Evict

Set a TTL (in seconds) for models loaded via API requests.

```json
{
  "ttl": 300
}
```

With `lms`:

```
lms load --ttl <seconds>
```

### Separate `reasoning_content` in Chat Completion responses

For DeepSeek R1 models, get reasoning content in a separate field. Turn on in App Settings > Developer.

---

###### [👾 LM Studio 0.3.6](/blog/lmstudio-v0.3.6) • 2025-01-06

### Tool and Function Calling API

Use any LLM that supports Tool Use and Function Calling through the OpenAI-like API.

---

###### [👾 LM Studio 0.3.5](/blog/lmstudio-v0.3.5) • 2024-10-22

### Introducing `lms get`: download models from the terminal

You can now download models directly from the terminal using a keyword or a full Hugging Face URL.

```bash
lms get deepseek-r1
lms get <hugging face url>
lms get deepseek-r1 --mlx
```
