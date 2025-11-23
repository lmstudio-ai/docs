---
title: "`lms dev` (Beta)"
sidebar_title: "`lms dev`"
description: Start a plugin dev server or install a local plugin (beta).
index: 3
---

Use `lms dev` inside a plugin project to run a local dev server that rebuilds and reloads on file changes.

This feature is a part of LM Studio [Plugins](/docs/typescript/plugins), currently in private beta.

### Run the dev plugin server

```shell
lms dev
```

This verifies `manifest.json`, installs dependencies if needed, and starts a watcher that rebuilds the plugin on changes. Supported runners: Node/ECMAScript and Deno.

### Install the plugin instead of running dev

```shell
lms dev --install
```

### Flags
```lms_params
- name: "-i, --install"
  type: "flag"
  optional: true
  description: "Install the plugin into LM Studio instead of running the dev server"
- name: "--no-notify"
  type: "flag"
  optional: true
  description: "Do not show the \"Plugin started\" notification in LM Studio"
```