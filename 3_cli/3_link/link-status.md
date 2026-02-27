---
title: "`lms link status`"
sidebar_title: "`lms link status`"
description: Check LM Link connection status and see connected peers.
index: 3
---

The `lms link status` command shows whether LM Link is enabled on this device, and lists connected peers and their loaded models.

### Flags

```lms_params
- name: "--json"
  type: "flag"
  optional: true
  description: "Output the status in JSON format"
```

## Check status

```shell
lms link status
```

Displays this device's name, connection state, and a list of connected peers with their currently loaded models.

### JSON output

For scripting or automation:

```shell
lms link status --json
```

### Enable or disable LM Link

- [`lms link enable`](/docs/cli/link/link-enable) — enable LM Link on this device.
- [`lms link disable`](/docs/cli/link/link-disable) — disable LM Link on this device.

### Learn more

See the [LM Link documentation](/docs/lmlink) for a full overview of LM Link.
