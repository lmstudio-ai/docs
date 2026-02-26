---
title: Set a preferred device 
sidebar_title: Set a preferred device 
description: Choose a preferred device to load models via LM Link
index: 2
---

## Choosing a preferred device

When the same model is available on multiple devices in the link, LM Link uses the preferred device to load and use the model. This setting is per-machine: each device on the link independently controls which remote machine it prefers.

This is especially relevant when accessing remote models via the SDK or [REST API](/docs/developer/rest/lmlink).

### Machines with GUI

In the app, head to the LM Link page, select the device and toggle the "Set as preferred device" option.

<img src="/assets/docs/lmlink-preferred.png" style="width: 75%;" data-caption="Set a device as your preferred device" />


### Machines without GUI

To set a preferred device from the terminal, use the following command:

```bash
lms link set-preferred-device
```


