---
title: Codex
description: Use Codex with LM Studio
index: 3
---

Codex can talk to LM Studio via the OpenAI-compatible `POST /v1/responses` endpoint.
See: [OpenAI-compatible Responses endpoint](/docs/developer/openai-compat/responses).

<img src="/assets/docs/codex.webp" style="width: 100%;" data-caption="Codex configured to use LM Studio via the OpenAI-compatible API" />

### 1) Start LM Studio's local server

Make sure LM Studio is running as a server (default port `1234`).

You can start it from the app, or from the terminal with `lms`:

```bash
lms server start --port 1234
```

### 2) Run Codex against a local model

Run Codex as you normally would, but with the `--oss` flag to point it to LM Studio.

Example:

```bash
codex --oss
```


By default, Codex will download and use [openai/gpt-oss-20b](https://lmstudio.ai/models/openai/gpt-oss-20b).

```lms_protip
Use a model (and server/model settings) with more than ~25k context length. Tools like Codex can consume a lot of context.
```

You can also use any other model you have available in LM Studio. For example:

```bash
codex --oss -m ibm/granite-4-micro
```

If you're running into trouble, hop onto our [Discord](https://discord.gg/lmstudio)
