---
title: "`lms link enable`"
sidebar_title: "`lms link enable`"
description: Enable LM Link on this device from the CLI.
index: 1
---

The `lms link enable` command enables LM Link on this device, allowing it to connect with other devices on the same link.

```lms_info
LM Link requires an LM Studio account. Run `lms login` first if you haven't already.
```

## Enable LM Link

```shell
lms link enable
```

After enabling, the CLI waits for a connection to be established. If there are issues, the relevant next step is printed.

### Check the connection status

See [`lms link status`](/docs/cli/link/link-status) to verify the connection and see connected peers.

### Disable LM Link

See [`lms link disable`](/docs/cli/link/link-disable) to turn LM Link off.

### Learn more

See the [LM Link documentation](/docs/lmlink) for a full overview of LM Link.
