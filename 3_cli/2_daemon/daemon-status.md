---
title: "`lms daemon status`"
sidebar_title: "`lms daemon status`"
description: Check whether llmster is running.
index: 3
---

The `lms daemon status` command reports whether llmster is currently running.

### Flags

```lms_params
- name: "--json"
  type: "flag"
  optional: true
  description: "Output the status in JSON format"
```

## Check daemon status

```shell
lms daemon status
```

### JSON output

For scripting or automation:

```shell
lms daemon status --json
```

Example output when running:
```json
{"status":"running","pid":12345,"isDaemon":true}
```

Example output when not running:
```json
{"status":"not-running"}
```

### Start or stop the daemon

- [`lms daemon up`](/docs/cli/daemon/daemon-up) — start the daemon.
- [`lms daemon down`](/docs/cli/daemon/daemon-down) — stop the daemon.

To find out more about llmster, see [Headless Mode](/docs/developer/core/headless).