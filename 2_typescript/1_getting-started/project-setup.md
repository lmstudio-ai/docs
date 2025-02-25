---
title: "Project Setup"
description: "Set up your `lmstudio.js` app, script, or notebook."
index: 2
---

## Install in an Exiting Project

If you have already created a project and would like to use `lmstudio.js` in it, you can install it using npm, yarn, or pnpm.

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

## Creating a New `node` Project

If you would like to create a new `node` project, you can use the following command:

```lms_code_snippet
  variants:
    TypeScript (Recommended):
      language: bash
      code: |
        lms create node-typescript
    Javascript:
      language: bash
      code: |
        lms create node-javascript
```
