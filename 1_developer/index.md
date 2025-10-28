---
title: LM Studio Developer Docs
sidebar_title: Introduction
description: Build with LM Studio's local APIs and SDKs — TypeScript, Python, REST, and OpenAI‑compatible endpoints.
index: 1
---

```lms_hstack
## Get to know the stack

- TypeScript SDK: [lmstudio-js](/docs/typescript)
- Python SDK: [lmstudio-python](/docs/python)
- OpenAI‑compatible: [Chat, Responses, Embeddings](/docs/developer/openai-compat)
- LM Studio CLI: [`lms`](/docs/cli)

:::split:::

## What you can build

- Chat and text generation with streaming
- Structured output (JSON schema)
- Tool calling and local agents
- Embeddings and tokenization
- Model management (JIT load, TTL, auto‑evict)
```

## Super quick start

### TypeScript (`lmstudio-js`)

```bash
npm install @lmstudio/sdk
```

```ts
import { LMStudioClient } from "@lmstudio/sdk";

const client = new LMStudioClient();
const model = await client.llm.model("openai/gpt-oss-20b");
const result = await model.respond("Who are you, and what can you do?");

console.info(result.content);
```

Full docs: [lmstudio-js](/docs/typescript), Source: [GitHub](https://github.com/lmstudio-ai/lmstudio-js)

### Python (`lmstudio-python`)

```bash
pip install lmstudio
```

```python
import lmstudio as lms

with lms.Client() as client:
    model = client.llm.model("openai/gpt-oss-20b")
    result = model.respond("Who are you, and what can you do?")
    print(result)
```

Full docs: [lmstudio-python](/docs/python), Source: [GitHub](https://github.com/lmstudio-ai/lmstudio-python)

### Try a minimal HTTP request (OpenAI‑compatible)

```bash
lms server start --port 1234
```

```bash
curl http://localhost:1234/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "openai/gpt-oss-20b",
    "messages": [{"role": "user", "content": "Who are you, and what can you do?"}]
  }'
```

Full docs: [OpenAI‑compatible endpoints](/docs/developer/openai-compat)

## Helpful links

- API Changelog: [/docs/developer/api-changelog](/docs/developer/api-changelog)
- Local server basics: [/docs/developer/core](/docs/developer/core)
- CLI reference: [/docs/cli](/docs/cli)
- Community: [Discord](https://discord.gg/lmstudio)
