---
title: "`lmstudio-js` (TypeScript SDK)"
sidebar_title: "Introduction"
description: "Getting started with LM Studio's Typescript / JavaScript SDK"
---

The SDK provides you a set of programmatic tools to interact with LLMs, embeddings models, and agentic flows.

## Installing the SDK

`lmstudio-js` is available as an npm package. You can install it using npm, yarn, or pnpm.

```lms_code_snippet
  variants:
    npm:
      language: bash
      code: |
        npm install @lmstudio/sdk --save
    yarn:
      language: bash
      code: |
        yarn add @lmstudio/sdk
    pnpm:
      language: bash
      code: |
        pnpm add @lmstudio/sdk
```

For the source code and open source contribution, visit [lmstudio.js](https://github.com/lmstudio-ai/lmstudio.js) on GitHub.

## Features

- Use LLMs to [respond in chats](./typescript/llm-prediction/chat-completion) or predict [text completions](./typescript/llm-prediction/completion)
- Define functions as tools, and turn LLMs into [autonomous agents](./typescript/agent/act) that run completely locally
- [Load](./typescript/manage-models/loading), [configure](./typescript/llm-prediction/parameters), and [unload](./typescript/manage-models/loading) models from memory
- Supports for both browser and any Node-compatible environments
- Generate embeddings for text, and more!

## Quick Example: Chat with a Llama Model

```lms_code_snippet
  title: "index.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";
        const client = new LMStudioClient();

        const model = await client.llm.model("llama-3.2-1b-instruct");
        const result = await model.respond("What is the meaning of life?");

        console.info(result.content);
```

### Getting Local Models

The above code requires the Llama 3.2 1B. If you don't have the model, run the following command in the terminal to download it.

```bash
lms get llama-3.2-1b-instruct
```

Read more about `lms get` in LM Studio's CLI [here](./cli/get).
