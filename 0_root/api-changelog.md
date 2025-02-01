---
title: API Changelog
description: Updates and new features to the LM Studio API
index: 2
---

###### [👾 LM Studio 0.3.9](blog/lmstudio-v0.3.9) • 2025-01-30

### Idle TTL and Auto Evict

Set a TTL (in seconds) for models loaded via API requests (docs article: [Idle TTL and Auto-Evict](/docs/api/ttl-and-auto-evict))

```diff
curl http://localhost:1234/api/v0/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "deepseek-r1-distill-qwen-7b",
    "messages": [ ... ]
+   "ttl": 300,
}'
```

With `lms`:

```
lms load --ttl <seconds>
```

### Separate `reasoning_content` in Chat Completion responses

For DeepSeek R1 models, get reasoning content in a separate field. See more [here](/blog/lmstudio-v0.3.9#separate-reasoningcontent-in-chat-completion-responses).

Turn this on in App Settings > Developer.

---

<br>

###### [👾 LM Studio 0.3.6](blog/lmstudio-v0.3.6) • 2025-01-06

### Tool and Function Calling API

Use any LLM that supports Tool Use and Function Calling through the OpenAI-like API.

Docs: [Tool Use and Function Calling](/docs/api/tools).

---

<br>

###### [👾 LM Studio 0.3.5](blog/lmstudio-v0.3.5) • 2024-10-22

### Introducing `lms get`: download models from the terminal

You can now download models directly from the terminal using a keyword

```bash
lms get deepseek-r1
```

or a full Hugging Face URL

```bash
lms get <hugging face url>
```

To filter for MLX models only, add `--mlx` to the command.

```bash
lms get deepseek-r1 --mlx
```
