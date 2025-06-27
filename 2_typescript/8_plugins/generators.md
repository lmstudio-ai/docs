---
title: "Generators"
description: "Writing generators for LM Studio plugins using TypeScript"
index: 4
---

```lms_private_beta
Plugin support is currently in private beta. [Join the beta here](https://forms.gle/ZPfGLMvVC6DbSRQm9).
```

Generators are replacement for local LLMs. They act like a token source. When a plugin with a generator is used, LM Studio will no longer use the local model to generate text. The generator will be used instead.

Generators are useful for implementing adapters for external models, such as using a remote LM Studio instance or other online models.

## Text-Only Generators

## Tool Call Support for Generators

## Examples

The following are some plugins that make use of generators:

- [lmstudio/openai-compat-endpoint](https://lmstudio.ai/lmstudio/openai-compat-endpoint)

  Use any OpenAI-compatible API in LM Studio.
