---
title: Use Claude Code with LM Studio
description: Point Claude Code at LM Studio's Anthropic-compatible API to use local models.
index: 3
---

Claude Code can talk to LM Studio via the Anthropic-compatible `POST /v1/messages` endpoint.
See: [Anthropic-compatible Messages endpoint](/docs/developer/anthropic-compat/messages).

<img src="/assets/docs/claude-code.webp" style="width: 100%;" data-caption="Claude Code configured to use LM Studio via the Anthropic-compatible API" />

## 1) Start LM Studio's local server

Make sure LM Studio is running as a server (default port `1234`).

You can start it from the app, or from the terminal with `lms`:

```bash
lms server start --port 1234
```

## 2) Configure Claude Code

Set these environment variables so the `claude` CLI points to your local LM Studio:

```bash
export ANTHROPIC_BASE_URL=http://localhost:1234
export ANTHROPIC_AUTH_TOKEN=lmstudio
```


Notes:
- If Require Authentication is enabled, set `ANTHROPIC_AUTH_TOKEN` to your LM Studio API token. To learn more, see: [Authentication](/docs/developer/core/authentication).

## 3) Run Claude Code against a local model

```bash
claude --model openai/gpt-oss-20b
```

```lms_protip
Use a model (and server/model settings) with more than ~25k context length. Tools like Claude Code can consume a lot of context.
```

## 4) If Require Authentication is enabled, use your LM Studio API token

If you turned on "Require Authentication" in LM Studio, create an API token and set:

```bash
export LM_API_TOKEN=<LMSTUDIO_TOKEN>
export ANTHROPIC_AUTH_TOKEN=$LM_API_TOKEN
```

When Require Authentication is enabled, LM Studio accepts both `x-api-key` and `Authorization: Bearer <token>`.

If you're running into trouble, hop onto our [Discord](https://discord.gg/lmstudio)
