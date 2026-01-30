---
title: LM Studio Developer Docs
sidebar_title: Introduction
description: Build with LM Studio's local APIs and SDKs — TypeScript, Python, REST, and OpenAI and Anthropic-compatible endpoints.
index: 1
---

```lms_hstack
## Get to know the stack

- TypeScript SDK: [lmstudio-js](/docs/typescript)
- Python SDK: [lmstudio-python](/docs/python)
- LM Studio REST API: [Stateful Chats, MCPs via API](/docs/developer/rest)
- OpenAI‑compatible: [Chat, Responses, Embeddings](/docs/developer/openai-compat)
- Anthropic-compatible: [Messages](/docs/developer/anthropic-compat)
- LM Studio CLI: [`lms`](/docs/cli)

:::split:::

## What you can build

- Chat and text generation with streaming
- Tool calling and local agents with MCP
- Structured output (JSON schema)
- Embeddings and tokenization
- Model management (load, download, list)
```

## Install `llmster` for headless deployments

`llmster` is LM Studio's core, packaged as a daemon for headless deployment on servers, cloud instances, or CI. The daemon runs standalone, and it is not dependent on the LM Studio GUI.

**Mac / Linux**

```bash
curl -fsSL https://lmstudio.ai/install.sh | bash
```

**Windows**

```powershell
irm https://lmstudio.ai/install.ps1 | iex
```

**Basic usage**

```bash
lms daemon up          # Start the daemon
lms get <model>        # Download a model
lms server start       # Start the local server
lms chat               # Open an interactive session
```

Learn more: [Headless deployments](/blog/0.4.0#deploy-on-servers-deploy-in-ci-deploy-anywhere)

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
