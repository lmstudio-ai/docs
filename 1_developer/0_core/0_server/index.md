---
title: LM Studio as a Local LLM API Server
sidebar_title: Running the Server
description: Run an LLM API server on `localhost` with LM Studio
fullPage: false
index: 1
---

You can serve local LLMs from LM Studio's Developer tab, either on `localhost` or on the network.

LM Studio's APIs can be used through [REST API](/docs/developer/rest), client libraries like [lmstudio-js](/docs/typescript) and [lmstudio-python](/docs/python), and [OpenAI compatibility endpoints](/docs/developer/openai-compat)

<img src="/assets/docs/server.png" style="" data-caption="Load and serve LLMs from LM Studio" />

### Running the server

To run the server, go to the Developer tab in LM Studio, and toggle the "Start server" switch to start the API server.

<img src="/assets/docs/server-start.png" style="" data-caption="Start the LM Studio API Server" />



Alternatively, you can use `lms` ([LM Studio's CLI](/docs/cli)) to start the server from your terminal:

```bash
lms server start
```


### API options

- [LM Studio REST API](/docs/developer/rest)
- [TypeScript SDK](/docs/typescript) - `lmstudio-js`
- [Python SDK](/docs/python) - `lmstudio-python`
- [OpenAI compatibility endpoints](/docs/developer/openai-compat)
