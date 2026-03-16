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

## Quick Start: Onyx Cloud

An alternative, faster way to get started with Onyx is via [Onyx Cloud](https://cloud.onyx.app).

Since Onyx Cloud runs remotely, it cannot access `localhost` on your machine. You'll need to expose your LM Studio server using a tunneling service like [ngrok](https://ngrok.com).

### 1) Sign up for Onyx Cloud

Go to [cloud.onyx.app](https://cloud.onyx.app) and sign up for a free trial — no credit card required.

### 2) Start LM Studio's local server

Make sure LM Studio is running as a server (default port `1234`).

```bash
lms server start --port 1234
```

```lms_protip
Use a model with more than ~25k context length. Onyx's agentic features can consume a lot of context.
```

### 3) Expose your LM Studio server

Because Onyx Cloud runs on remote infrastructure, it needs a publicly reachable URL to connect to your LM Studio server. Use a tunnel to expose your local server:

```bash
ngrok http 1234
```

This will give you a public URL like `https://abcd-1234.ngrok-free.app`. Copy this URL — you'll need it in the next step.

### 4) Add LM Studio as a provider

In Onyx, navigate to **Admin Panel → Configuration → LLM** and select **LM Studio** from the list of providers.

Set the **API Base URL** to the public URL from your tunnel:

| Field            | Value                                                                                     |
| ---------------- | ----------------------------------------------------------------------------------------- |
| **API Base URL** | Your tunnel URL (e.g., `https://abcd-1234.ngrok-free.app`)                               |
| **API Key**      | Leave blank unless you have [authentication](/docs/developer/core/authentication) enabled |

Onyx will automatically connect to LM Studio and discover your loaded models.



### 5) Select your models and start chatting

Enable the models you want to use in Onyx from the auto-discovered list, save, and you're ready to go! Open Onyx's chat interface and start using your local LM Studio models with agents powered by your docs.



---

## Tips

- Onyx auto-discovers models loaded in LM Studio along with their capabilities (vision, reasoning) and context length.
- For best results, use a model with strong instruction-following and tool-use capabilities (e.g., Qwen 3.5).

If you're running into trouble, hop onto the [LM Studio Discord](https://discord.gg/lmstudio) or the [Onyx Discord](https://discord.gg/Pk3qzRKAEx)!
