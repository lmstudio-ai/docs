---
title: Onyx
description: Use Onyx with LM Studio
index: 4
---

[Onyx](https://www.onyx.app/) is an open source AI platform that connects your LLMs to your organization's knowledge and applications. It provides chat, AI agents, internal search, web search, actions, and more — all in one place.

Onyx has a built-in integration to LM Studio that auto-discovers your loaded models, so setup takes just a few clicks.



```lms_protip
Have a powerful LLM rig? Use [LM Link](/docs/integrations/lmlink) to run Onyx from one machine while the model runs on another.
```

## Quick Start: Self-Hosted Onyx

For full data privacy, you can self-host both Onyx and LM Studio on your own infrastructure.

### 1) Deploy Onyx

Run the Onyx install script (requires Bash, Docker, and at least 4 CPU cores / 8GB RAM):

```bash
curl -fsSL https://raw.githubusercontent.com/onyx-dot-app/onyx/main/deployment/docker_compose/install.sh > install.sh && chmod +x install.sh && ./install.sh
```

The script will pull containers and start Onyx. Once running, access the Onyx UI at `http://localhost:3000`.

For more deployment options (Kubernetes, cloud providers, etc.), see the [Onyx deployment docs](https://docs.onyx.app/deployment/getting_started/quickstart).

### 2) Start LM Studio's local server

```bash
lms server start --port 1234
```

If LM Studio is running on a different machine than Onyx, make sure the LM Studio server is accessible from the Onyx host (e.g., `http://<lm-studio-host>:1234`).

### 3) Add LM Studio as a provider in Onyx

Navigate to **Admin Panel → Configuration → LLM** and select **LM Studio** from the list of providers.

Set the **API Base URL** to your LM Studio server address:


| Field            | Value                                                                                     |
| ---------------- | ----------------------------------------------------------------------------------------- |
| **API Base URL** | `http://localhost:1234` (or `http://<lm-studio-host>:1234` if on a different machine)     |
| **API Key**      | Leave blank unless you have [authentication](/docs/developer/core/authentication) enabled |


Onyx will automatically connect and discover your loaded models, including their context length and capabilities (vision, reasoning).



### 4) Select your model and start chatting

Enable your models from the auto-discovered list, save, and you're ready to go!

---

## Tips

- Onyx auto-discovers models loaded in LM Studio along with their capabilities (vision, reasoning) and context length.
- For best results, use a model with strong instruction-following and tool-use capabilities (e.g., Qwen 3.5).
- Check out the [Onyx docs](https://docs.onyx.app/) for more details on setup and configuration.

If you're running into trouble, hop onto the [LM Studio Discord](https://discord.gg/lmstudio) or the [Onyx Discord](https://discord.gg/Pk3qzRKAEx)!
