---
title: Using LM Link
sidebar_title: Using with LM Link
description: Use a remote device's model via the REST API with LM Link
index: 3
---

## Overview

With [LM Link](/docs/lmlink), you can use a model loaded on a remote device as if it were loaded locally — from any machine on the same link. This naturally extends to the REST API and SDK: your laptop can make requests to `localhost` and have them served by a powerful remote machine on your network.

Requests to `localhost` still work as normal. LM Studio internally uses the model on the remote device as if it were loaded locally. For models present on multiple devices, the REST API will use the model on the preferred device.

<img src="/assets/marketing/docs/rest-link-diagram.png" data-caption="Sequence diagram: REST API request routed through LM Link to a remote device" />

The preferred device setting is per-machine. Each device on the link independently controls which remote machine it prefers. See [how to set a preferred device](/docs/lmlink/basics/preferred-device) for more details.

## Use the REST API as normal

Use the REST API exactly as you would locally. See the [REST API docs](/docs/developer/rest) for usage details.

If you're running into trouble, hop onto our [Discord](https://discord.gg/lmstudio)
