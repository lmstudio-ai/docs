---
title: Use Remote Models with LM Link
sidebar_title: Remote Models with LM Link
description: Run a Bionic session with a local model shared by another linked device.
index: 1
---

LM Link lets Bionic use local models from another device. In the model picker, these models are labeled **Remote**.

The conversation stays on the device where you use Bionic. Model processing happens on the linked device over an end-to-end encrypted connection.

## Enable LM Link

On each device:

1. Open **Settings**.
2. Under **Devices**, select **LM Link**.
3. Sign in if prompted.
4. Turn on **Enable LM Link**.
5. Check **Status** and wait for the device to be **Online**.

If access or connection information is stale, select **Refresh**. If LM Link is enabled but offline, select **Reconnect**.

Your devices appear under **Networks**. The default account network is labeled **Personal Network**. Select **Show all devices** to review the full device list.

For general device and network setup, see the [LM Link documentation](/docs/lmlink).

## Share models from the remote device

On the device that will run the model:

1. Download the local model on that device.
2. Open **Settings** → **LM Link**.
3. Under **This device**, turn on **Share local models**.
4. Keep LM Link online.

**Share local models** allows linked devices to discover and load models on that machine.

## Choose the remote model in Bionic

On the device where you are using Bionic:

1. Open a session's model picker.
2. Select a model labeled **Remote**.
3. Send the prompt as usual.

A remote model appears only while the other device is connected, sharing models, and has that model available.

## If a remote model is missing

Check that:

- LM Link is enabled and **Online** on both devices.
- Both devices appear in the same network.
- **Share local models** is on for the device hosting the model.
- The model is downloaded and indexed on that device.

LM Link does not require the remote device to expose a port to the public internet.

See [Choose a Cloud, Local, or Remote Model](/docs/bionic/models) for model-selection guidance.
