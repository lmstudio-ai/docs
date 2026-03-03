---
title: "`lms daemon up`"
sidebar_title: "`lms daemon up`"
description: Start llmster from the CLI.
index: 1
---

The `lms daemon up` command starts llmster

### Flags

```lms_params
- name: "--json"
  type: "flag"
  optional: true
  description: "Output the result in JSON format"
```

## Start the daemon

```shell
lms daemon up
```

If the daemon is not already running, this starts it and prints the PID. If it is already running, it reports the current status.

### JSON output

For scripting or automation:

```shell
lms daemon up --json
```

Example output:
```json
{"status":"running","pid":26754,"isDaemon":true,"version":"0.4.4+1"}
```

### Check the daemon status

See [`lms daemon status`](/docs/cli/daemon/daemon-status) to check whether the daemon is running.

### Learn more

To find out more about llmster, see [Headless Mode](/docs/developer/core/headless).
