---
title: "`lmstudio.js`"
sidebar_title: "Introduction"
description: "Getting started with LM Studio's Typescript / JavaScript SDK"
---

`lmstudio.js` is LM Studio's official SDK for TypeScript/JavaScript. It supports both browser and any node-compatible environments.

With `lmstudio.js`, currently you can

- Use LLMs to predict text or continue conversations
- Manage models that are loaded into memory
- Programmatically search and download models
- Give LLMs tools and turn them into autonomous agents that runs completely locally
- ...and much more

## Installation

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

## Quick Example

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

The above code requires the Llama 3.2 1B. If you don't have the model, you can download it using the following command:

```bash
lms get llama-3.2-1b-instruct
```
