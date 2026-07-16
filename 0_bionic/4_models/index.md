---
title: Choose a Cloud, Local, or Remote Model
description: Pick where a Bionic session runs and choose a model that fits the task.
index: 1
---

Open the model picker in a session to choose its main model. Bionic labels models as **Cloud**, **Local**, or **Remote**.

## Cloud models

Choose a **Cloud** model when you want a hosted model without using your computer's memory for inference.

Cloud models require:

- An internet connection.
- A signed-in LM Studio account.
- Available personal or organization credits.

Cloud requests send the context needed for inference to LM Studio's cloud service. See [Understand Credits and Usage](/docs/bionic/accounts-plans-and-billing/credits-and-usage).

## Local models

Choose a **Local** model to run inference on your computer. The model must be downloaded and must fit your available hardware resources.

When a session uses a local model, Bionic loads it automatically. A larger model may give better results for some tasks, but it also needs more memory and can run more slowly.

See [Download Local Models](/docs/bionic/models/download-local-models).

## Remote models

A **Remote** model is a local model shared by another device through LM Link. The remote device handles inference, while the conversation stays on the device where you are using Bionic.

Remote models appear only while the linked device is available and sharing its local models.

## Choose for the task

Consider:

- Whether the model supports the tools and image input your task needs.
- Whether the work must stay on your own devices.
- The speed and memory available on the local or remote device.
- Cloud credit use.

If the model supports configurable reasoning, you can also choose a reasoning level for the session.

## Set a default

Open **Settings** → **General** and choose a **Root model** to use as the default for new sessions. Select **No default** if you prefer to choose each time.

You can change the model for an existing session from its model picker.
