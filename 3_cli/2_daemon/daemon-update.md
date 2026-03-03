---
title: "`lms daemon update`"
sidebar_title: "`lms daemon update`"
description: Update llmster to the latest version.
index: 4
---

The `lms daemon update` command fetches and installs the latest version of llmster.

### Flags

```lms_params
- name: "--beta"
  type: "flag"
  optional: true
  description: "Update to the latest beta release"
```

## Update the daemon

Stop the daemon first:

```shell
lms daemon down
```

Then run the update:

```shell
lms daemon update
```

Fetches the latest stable release and installs it.

### Update to the beta channel

```shell
lms daemon update --beta
```

### After updating

Start the daemon again to use the new version:

```shell
lms daemon up
```

To find out more about llmster, see [Headless Mode](/docs/developer/core/headless).
