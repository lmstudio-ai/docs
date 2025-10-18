---
title: LM Studio Developer Docs
sidebar_title: Introduction
description: Build with LM Studio's local APIs and SDKs — TypeScript, Python, REST, and OpenAI‑compatible endpoints.
index: 1
---

Build local‑first AI apps with LM Studio. Run models on your machine, serve an API locally or on your network, and integrate using SDKs or HTTP.

## Choose your path

- TypeScript SDK: [lmstudio-js](/docs/typescript)
- Python SDK: [lmstudio-python](/docs/python)
- REST API (beta): [Endpoints overview](/docs/developer/rest)
- OpenAI‑compatible: [Chat, Responses, Embeddings](/docs/developer/openai-compat)

## What you can build

- Chat and text generation with streaming
- Structured output (JSON schema)
- Tool calling and local agents
- Embeddings and tokenization
- Model management (JIT load, TTL, auto‑evict)

## Super quick start

### TypeScript (lmstudio-js)

```bash
npm install @lmstudio/sdk
```

```ts
import { LMStudioClient } from "@lmstudio/sdk";

const client = new LMStudioClient();
const model = await client.llm.model("llama-3.2-1b-instruct");
const result = await model.respond("Hello from LM Studio");

console.info(result.content);
```

Full docs: [lmstudio-js](/docs/typescript)

### Python (lmstudio-python)

```bash
pip install lmstudio
```

```python
import lmstudio as lms

with lms.Client() as client:
    model = client.llm.model("llama-3.2-1b-instruct")
    result = model.respond("Hello from LM Studio")
    print(result)
```

Full docs: [lmstudio-python](/docs/python)

### Try a minimal HTTP request (OpenAI‑compatible)

```bash
lms server start --port 1234
```

```bash
curl http://localhost:1234/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "llama-3.2-1b-instruct",
    "messages": [{"role": "user", "content": "Hello from LM Studio"}]
  }'
```

Full docs: [OpenAI‑compatible endpoints](/docs/developer/openai-compat)

## Helpful links

- API Changelog: [/docs/developer/api-changelog](/docs/developer/api-changelog)
- Local server basics: [/docs/developer/core](/docs/developer/core)
- CLI reference: [/docs/cli](/docs/cli)
- Community: [Discord](https://discord.gg/aPQfnNkxGC)
