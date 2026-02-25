---
title: Set a preferred device 
sidebar_title: Set a preferred device 
description: Choose a preferred device to load models via LM Link
index: 2
---

## Choosing a preferred device

When the same model is available on multiple devices in the link, LM Link routes requests through the preferred device. Each device on the network can configure its own preferred device independently.

This is especially relevant when accessing remote models via the SDK or REST API.

### Machines with GUI

In the app, head to the LM Link page, select the device and toggle the "Set as preferred device" option.

<img src="/assets/docs/lmlink-preferred.png" style="width: 75%;" data-caption="Set a device as your preferred device" />


### Machines without GUI

To set a preferred device from the terminal, use the following command:

```bash
lms link set-preferred-device
```
