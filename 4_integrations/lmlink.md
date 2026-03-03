---
title: Using LM Link with Integrations
sidebar_title: Working with LM Link
description: Use a remote device's model with coding tools like Claude Code and Codex via LM Link
index: 1
---

With [LM Link](/docs/lmlink), your coding tools can run models on a remote device (like a dedicated LLM rig on your network) while you work from your laptop

<img src="/assets/docs/lmlink-claudecode.gif" style="width: 100%;" data-caption="Claude Code using a model loaded on a remote device via LM Link" />

## Use your integration as normal

Start LM Studio's server on your local machine and configure your tool to point to it. Model loads are routed to the device the model is loaded on or the preferred device if set.

Your local machine handles the API surface at `localhost:1234`, while the model runs on the device the model is present on.

```bash
lms server start --port 1234
```

### Claude Code

```bash
export ANTHROPIC_BASE_URL=http://localhost:1234
export ANTHROPIC_AUTH_TOKEN=lmstudio
claude --model qwen3-8b
```

See the full [Claude Code](/docs/integrations/claude-code) guide.

### Codex

```bash
codex --oss -m qwen3-8b
```


See the full [Codex](/docs/integrations/codex) guide.

## Set a preferred device

To use a model on a specific remote device, set the device as the preferred device.


See [set a preferred device](/docs/lmlink/basics/preferred-device) for more details.


If you're running into trouble, hop onto our [Discord](https://discord.gg/lmstudio)
