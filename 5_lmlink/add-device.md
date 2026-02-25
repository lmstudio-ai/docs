---
title: Add a Device
sidebar_title: Add a device
description: Add a new device to your LM Link.
index: 2
---

## Add a device

<img src="/assets/docs/lmlink-adddevice.png" style="" data-caption="Add Device modal in LM Link" />

### Machines with GUI
To begin using LM Link, add an additional device to the link:

1. Download and install LM Studio on the device, at [https://lmstudio.ai/download](https://lmstudio.ai/download)
2. Click on LM Link in the sidebar and follow the steps to enable LM Link.

Once LM Link is enabled, your devices will connect to each other automatically.

### Machines without GUI
To add a headless machine, connect remotely by using llmster in the terminal:

1. Install `llmster` on the headless machine
```bash
curl -fsSL https://lmstudio.ai/install.sh | bash
```
2. Log in from the terminal 
```bash
lms login
```
3. Follow the instructions in your terminal output to complete login.
4. Once logged in, run the following command:
```bash
lms link enable
```

Your devices will automatically discover each other over the link, and your headless machine will immediately appear on the LM Link page for your other device. Once connected, models from remote machines will appear locally for loading and inference. 

## Load models on remote machines

<img src="/assets/docs/lmlink-useremotemodels.png" style="" data-caption="Load models on remote devices with LM Link" />

When using LM Link, the model loader shows both local models and remote models on linked devices. 

You can filter the model loader to display only local or remote models, or to display all available models at once. Remote models can be loaded and configured with the same familiar controls, either in the GUI or by using lms in the terminal.

If you have the same model on multiple devices, they will show up as separate entries, with the associated device name identified. If you are loading models via API/SDK, you can set a preferred device from the in-app LM Link page, or use command `lms link set-preferred-device`. Once set, the model will always load on your preferred device.
 
Using LM Studio’s parallel requests, you can also serve multiple clients simultaneously across your LM Link network.




