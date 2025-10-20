---
title: Serve on Local Network
sidebar_title: Serve on Local Network
description: Allow other devices in your network use this LM Studio API server
fullPage: false
index: 3
---


Enabling the "Serve on Local Network" option allows the LM Studio API server running on your machine to be accessible by other devices connected to the same local network.

This is useful for scenarios where you want to:
- Use a local LLM on your other less powerful devices by connecting them to a more powerful machine running LM Studio.
- Let multiple people use a single LM Studio instance on the network.
- Use the API from IoT devices, edge computing units, or other services in your local setup.

Once enabled, the server will bind to your local network IP address instead of localhost. The API access URL will be updated accordingly which you can use in your applications.

<img src="/assets/docs/serve-local-network.png" style="" data-caption="Serve LM Studio API Server on Local Network" />
