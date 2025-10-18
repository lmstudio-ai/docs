---
title: "Project Setup"
sidebar_title: "Project Setup"
description: "Set up your `lmstudio-js` app or script."
index: 2
---

`@lmstudio/sdk` is a library published on npm that allows you to use `lmstudio-js` in your own projects. It is open source and it's developed on GitHub. You can find the source code [here](https://github.com/lmstudio-ai/lmstudio-js).

## Creating a New `node` Project

Use the following command to start an interactive project setup:

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

## Add `lmstudio-js` to an Exiting Project

If you have already created a project and would like to use `lmstudio-js` in it, you can install it using npm, yarn, or pnpm.

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
