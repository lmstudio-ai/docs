---
title: "`lms link set-preferred-device`"
sidebar_title: "`lms link set-preferred-device`"
description: Set the preferred device for model resolution on LM Link.
index: 5
---

The `lms link set-preferred-device` command sets which device on the link is used when a model is available on multiple connected devices.

## Set a preferred device

Run the command without arguments to pick from an interactive list of connected devices:

```shell
lms link set-preferred-device
```

Or pass the device identifier directly to skip the prompt:

```shell
lms link set-preferred-device <deviceIdentifier>
```

Device identifiers are listed in the output of [`lms link status`](/docs/cli/link/link-status).

See [Using LM Link with the REST API](/docs/rest-api/lmlink) for more on how preferred devices affect model routing.

### Learn more

See the [LM Link documentation](/docs/lmlink) for a full overview of LM Link.
