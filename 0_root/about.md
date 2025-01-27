---
title: About LM Studio
description: Learn how to run Llama, DeepSeek, Phi, and other LLMs locally with LM Studio.
index: 2
---

LM Studio is a desktop app for developing and experimenting with LLMs locally on your computer.

**Key functionality**

1. A desktop application for running local LLMs
2. A familiar chat interface
3. Search & download functionality (via Hugging Face 🤗)
4. A local server that can listen on OpenAI-like endpoints
5. Systems for managing local models and configurations

<hr>

### How do I install LM Studio?

Head over to the [Downloads page](/download) and download an installer for your operating system.

LM Studio is available for macOS, Windows, and Linux.

<hr>

### System requirements

LM Studio generally supports Apple Silicon Macs, x64/ARM64 Windows PCs, and x64 Linux PCs.

Consult the [System Requirements](intro/system-requirements) page for more detailed information.

<hr>

### Run llama.cpp (GGUF) or MLX models

LM Studio supports running LLMs on Mac, Windows, and Linux using [`llama.cpp`](https://github.com/ggerganov/llama.cpp).

On Apple Silicon Macs, LM Studio also supports running LLMs using Apple's [`MLX`](https://github.com/ml-explore/mlx).

To install or manage LM Runtimes, press `⌘` `Shift` `R` on Mac or `Ctrl` `Shift` `R` on Windows/Linux.

<hr>

### Run an LLM like `Llama`, `Phi`, or `DeepSeek R1` on your computer

To run an LLM on your computer you first need to download the model weights.

You can do this right within LM Studio! See [Download an LLM](basics/download-model) for guidance.

<hr>

### Chat with documents entirely offline on your computer

You can attach documents to your chat messages and interact with them entirely offline, also known as "RAG".

Read more about how to use this feature in the [Chat with Documents](basics/rag) guide.

### Use LM Studio's API from your own apps and scripts

LM Studio provides a REST API that you can use to interact with your local models from your own apps and scripts.

- [OpenAI Compatibility API](api/openai-api)
- [LM Studio REST API (beta)](api/rest-api)

<hr>

### Community

Join the LM Studio community on [Discord](https://discord.gg/aPQfnNkxGC) to ask questions, share knowledge, and get help from other users and the LM Studio team.
