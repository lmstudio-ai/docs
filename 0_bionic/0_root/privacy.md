---
title: Privacy in LM Studio Bionic
description: Understand how model choice and connected tools affect where your data is processed.
index: 2
---

LM Studio Bionic is built around strong zero data retention: your work stays yours.

Where your data is processed depends on the model and tools you choose.

## Local models

With a **Local** model, model inference runs on your computer. Your session can still use network services if you enable tools such as web search or connect an external app.

## Cloud models

With a **Cloud** model, Bionic sends the context needed for the request, including any images you include, to LM Studio's cloud inference service for processing.

Cloud model use requires an account and credits. Bionic's detailed cloud retention terms are not shown in the app, so avoid assuming a specific retention period from this page.

## Remote models with LM Link

With a **Remote** model, the conversation stays on your current device while inference runs on a linked device. The connection between devices is end-to-end encrypted.

Learn more in [Use remote models with LM Link](/docs/bionic/lmlink).

## Connected services

Web search, websites, and connected apps have their own data practices. Only send them information that you are comfortable sharing with that service.

For sensitive work:

- Prefer a **Local** model when the task can stay on one device.
- Check which files and images are included before sending a prompt.
- Only enable connected apps that you trust.
- Remove secrets and private data that the task does not need.

See [Cloud, local, and remote models](/docs/bionic/models) for help choosing a model.
