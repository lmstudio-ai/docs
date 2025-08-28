---
title: "Introduction"
description: "Writing tools providers for LM Studio plugins using TypeScript"
index: 1
---

```lms_private_beta
Plugin support is currently in private beta. [Join the beta here](https://forms.gle/ZPfGLMvVC6DbSRQm9).
```

Tools provider is a function that returns an array of tools that the model can use during generation.

## Examples

The following are some plugins that make use of tools providers:

- [lmstudio/wikipedia](https://lmstudio.ai/lmstudio/wikipedia)

  Gives the LLM tools to search and read Wikipedia articles.

- [lmstudio/js-code-sandbox](https://lmstudio.ai/lmstudio/js-code-sandbox)

  Gives the LLM tools to run JavaScript/TypeScript code in a sandbox environment using [deno](https://deno.com/).

- [lmstudio/dice](https://lmstudio.ai/lmstudio/dice)

  Allows the LLM to generate random numbers using "dice".
