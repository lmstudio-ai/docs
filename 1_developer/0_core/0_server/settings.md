---
title: Server Settings
sidebar_title: Server Settings
description: Configure server settings for LM Studio API Server
fullPage: false
index: 2
---

You can configure server settings, such as the port number, whether to allow other API clients to access the server and MCP features.

<img src="/assets/docs/server-settings.png" style="" data-caption="Configure LM Studio API Server settings" />


### Settings information

```lms_params
- name: Server Port
  type: Integer
  optional: false
  description: Port number on which the LM Studio API server listens for incoming connections.
  unstyledName: true
- name: Require Authentication
  type: Switch
  description: Require API clients to provide a valid API token via the `Authorization` header. Learn more in the [Authentication](/docs/developer/core/authentication) section.
  unstyledName: true
- name: Serve on Local Network
  type: Switch
  description: Allow other devices on the same local network to access the API server. Learn more in the [Serve on Local Network](/docs/developer/core/server/serve-on-network) section.
  unstyledName: true
- name: Allow per-request MCPs
  type: Switch
  description: Allow API clients to use MCP (Model Control Protocol) servers that are not in your mcp.json. These MCP connections are ephemeral, only existing as long as the request. At the moment, only remote MCPs are supported.
  unstyledName: true
- name: Allow calling servers from mcp.json
  type: Switch
  description: Allow API clients to use servers you defined in your mcp.json in LM Studio. This can be a security risk if you've defined MCP servers that have access to your file system or private data. This option requires "Require Authentication" to be enabled.
  unstyledName: true
- name: Enable CORS
  type: Switch
  description: Enable Cross-Origin Resource Sharing (CORS) to allow applications from different origins to access the API.
  unstyledName: true
- name: Just in Time Model Loading
  type: Switch
  description: Load models dynamically at request time to save memory.
  unstyledName: true
- name: Auto Unload Unused JIT Models
  type: Switch
  description: Automatically unload JIT-loaded models from memory when they are no longer in use.
  unstyledName: true
- name: Only Keep Last JIT Loaded Model
  type: Switch
  description: Keep only the most recently used JIT-loaded model in memory to minimize RAM usag
  unstyledName: true
```
