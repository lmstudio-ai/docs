---
title: Using LM Link with Integrations
sidebar_title: Using LM Link with Integrations
description: Use a remote device's model with coding tools like Claude Code and Codex via LM Link
index: 4
---

With [LM Link](/docs/lmlink), your coding tools can run models on a remote device (like a dedicated LLM rig on your network) while you work from your laptop

<img src="/assets/docs/lmlink-claudecode.gif" style="width: 100%;" data-caption="Claude Code using a model loaded on a remote device via LM Link" />

## Set a preferred device

**In the app:** Go to the LM Link page, select the remote device, and toggle "Set as preferred device".

**In the terminal:**

```bash
lms link set-preferred-device
```

See [set a preferred device](/docs/lmlink/basics/preferred-device) for more details.

## Use your integration as normal

Once a preferred device is set, start LM Studio's server on your local machine and configure your tool to point to it. Model loads are routed to the preferred device automatically.

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

```lms_protip
The preferred device setting is per-machine. Each device on the link independently controls which remote machine it prefers.
```

Your laptop handles the API surface at `localhost:1234`, while the model runs on the preferred remote device. No extra configuration needed in the integration itself.

If you're running into trouble, hop onto our [Discord](https://discord.gg/lmstudio)
