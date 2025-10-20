---
title: Server Settings
sidebar_title: Server Settings
description: Configure server settings for LM Studio API Server
fullPage: false
index: 2
---

You can configure server settings, such as the port number, whether to allow other API clients to access the server and MCP features.

<img src="/assets/docs/server-config.png" style="" data-caption="Configure LM Studio API Server settings" />


### Settings information

```lms_params
- name: Server Port
  type: Integer
  optional: false
  description: Port number on which the LM Studio API server listens for incoming connections.
  unstyledName: true
- name: Serve on Local Network
  type: Switch
  description: Allow other devices on the same local network to access the API server. Learn more in the [Serve on Local Network](/docs/developer/core/server/serve-on-local) section.
  unstyledName: true
- name: Allow Per Request Remote MCPs
  type: Switch
  description: Enable sending requests to remote MCP (Model Control Protocol) servers on a per-request basis.
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
