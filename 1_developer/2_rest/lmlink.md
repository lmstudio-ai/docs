---
title: Using LM Link with the REST API
sidebar_title: Using with LM Link
description: Use a remote device's model via the REST API with LM Link
index: 3
---

## Overview

With [LM Link](/docs/lmlink), you can use a model loaded on a remote device (e.g. a powerful LLM rig on your network) via the REST API, from any machine on the same link, like your laptop.

When a preferred device is set, the model is loaded there automatically. Requests to `localhost` still work as normal. LM Studio internally uses the model on the remote device as if it were loaded locally.

<img src="/assets/docs/rest-link-diagram.png" data-caption="Sequence diagram: REST API request routed through LM Link to a remote device" />

See [how to set a preferred device](/docs/lmlink/basics/preferred-device) for more details.

## Use the REST API as normal

Once a preferred device is set, use the REST API exactly as you would locally. See the [REST API docs](/docs/rest-api) for usage details.

If you're running into trouble, hop onto our [Discord](https://discord.gg/lmstudio)
