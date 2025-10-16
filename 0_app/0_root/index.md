---
title: Welcome to LM Studio Docs!
sidebar_title: Welcome
description: Learn how to run Llama, DeepSeek, Qwen, Phi, and other LLMs locally with LM Studio.
index: 1
---

To get LM Studio, head over to the [Downloads page](/download) and download an installer for your operating system.

LM Studio is available for macOS, Windows, and Linux.

## What can I do with LM Studio?

1. Download and run local LLMs like gpt-oss or Llama, Qwen
2. Use a simple and flexible chat interface
3. Connect MCP servers and use them with local models
4. Search & download functionality (via Hugging Face 🤗)
5. Serve local models on OpenAI-like endpoints, locally and on the network
6. Manage your local models, prompts, and configurations

## System requirements

LM Studio generally supports Apple Silicon Macs, x64/ARM64 Windows PCs, and x64 Linux PCs.

Consult the [System Requirements](app/system-requirements) page for more detailed information.

## Run llama.cpp (GGUF) or MLX models

LM Studio supports running LLMs on Mac, Windows, and Linux using [`llama.cpp`](https://github.com/ggerganov/llama.cpp).

On Apple Silicon Macs, LM Studio also supports running LLMs using Apple's [`MLX`](https://github.com/ml-explore/mlx).

To install or manage LM Runtimes, press `⌘` `Shift` `R` on Mac or `Ctrl` `Shift` `R` on Windows/Linux.

## LM Studio as an MCP client

You can install MCP servers in LM Studio and use them with your local models.

See the docs for more: [Use MCP server](/docs/app/plugins/mcp).

If you're develping an MCP server, check out [Add to LM Studio Button](/docs/app/plugins/mcp/deeplink).

## Run an LLM like `gpt-oss`, `Llama`, `Qwen`, `Mistral`, or `DeepSeek R1` on your computer

To run an LLM on your computer you first need to download the model weights.

You can do this right within LM Studio! See [Download an LLM](app/basics/download-model) for guidance.

## Chat with documents entirely offline on your computer

You can attach documents to your chat messages and interact with them entirely offline, also known as "RAG".

Read more about how to use this feature in the [Chat with Documents](app/basics/rag) guide.

## Use LM Studio's API from your own apps and scripts

LM Studio provides a REST API that you can use to interact with your local models from your own apps and scripts.

- [OpenAI Compatibility API](api/openai-api)
- [LM Studio REST API (beta)](api/rest-api)

<br />

## Community

Join the LM Studio community on [Discord](https://discord.gg/aPQfnNkxGC) to ask questions, share knowledge, and get help from other users and the LM Studio team.
