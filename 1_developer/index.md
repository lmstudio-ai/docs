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
- LM Studio REST API: [Stateful Chats, MCPs via API](/docs/developer/rest)
- OpenAI‑compatible: [Chat, Responses, Embeddings](/docs/developer/openai-compat)
- LM Studio CLI: [`lms`](/docs/cli)

:::split:::

## What you can build

- Chat and text generation with streaming
- Tool calling and local agents with MCP
- Structured output (JSON schema)
- Embeddings and tokenization
- Model management (load, download, list)
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

### HTTP (LM Studio REST API)

```bash
lms server start --port 1234
```

```bash
curl http://localhost:1234/api/v1/chat \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $LM_API_TOKEN" \
  -d '{
    "model": "openai/gpt-oss-20b",
    "input": "Who are you, and what can you do?"
  }'
```

Full docs: [LM Studio REST API](/docs/developer/rest)

## Helpful links

- [API Changelog](/docs/developer/api-changelog)
- [Local server basics](/docs/developer/core)
- [CLI reference](/docs/cli)
- [Discord Community](https://discord.gg/lmstudio)
