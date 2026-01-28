---
title: "Setup llmster as a Startup Task on Linux"
sidebar_title: "Linux Startup Task"
description: "Configure llmster to run on startup using systemctl on Linux"
index: 3
---

`llmster`, LM Studio's headless daemon, can be configured to run on startup. This guide covers setting up `llmster` to launch, load a model, and start an HTTP server automatically using `systemctl` on Linux.

```lms_info
This guide is for Linux systems without a graphical interface. For machines with a GUI, you can configure LM Studio to [run as a service on login](/docs/developer/core/headless) instead.
```

## Install the Daemon

Run the following command to install `llmster`:

```bash
curl -fsSL https://lmstudio.ai/install.sh | bash
```

Verify the installation:

```bash
lms --help
```

## Download a Model

Download a model to use with the server:

```bash
lms get openai/gpt-oss-20b
```

The output will show the model path. You'll need this for the systemd configuration.

## Manual Test

Before configuring systemd, verify everything works manually.

Load the model:

```bash
lms load openai/gpt-oss-20b
```

Start the server:

```bash
lms server start
```

Verify the API is responding:

```bash
curl http://localhost:1234/v1/models
```

Stop the server when done testing:

```bash
lms server stop
```

## Create Systemd Service

Create `/etc/systemd/system/lmstudio.service`. Replace `YOUR_USERNAME` with your username.

```ini
[Unit]
Description=LM Studio Server

[Service]
Type=oneshot
RemainAfterExit=yes
User=YOUR_USERNAME
Environment="HOME=/home/YOUR_USERNAME"
ExecStartPre=/home/YOUR_USERNAME/.lmstudio/bin/lms daemon up
ExecStartPre=/home/YOUR_USERNAME/.lmstudio/bin/lms load openai/gpt-oss-20b --yes
ExecStart=/home/YOUR_USERNAME/.lmstudio/bin/lms server start
ExecStop=/home/YOUR_USERNAME/.lmstudio/bin/lms daemon down

[Install]
WantedBy=multi-user.target
```

This unit automatically loads the `openai/gpt-oss-20b` model on startup. Alternatively, you can avoid loading a specific model on startup and instead rely on [Just-In-Time (JIT) loading and Eviction](/docs/developer/core/ttl-and-auto-evict) in the server.

## Enable and Start the Service

```bash
sudo systemctl daemon-reload
sudo systemctl enable lmstudio.service
sudo systemctl start lmstudio.service
```

## Verify

Check the service status:

```bash
systemctl status lmstudio
```

Test the API:

```bash
curl http://localhost:1234/v1/models
```

## Service Management

```bash
# Stop the service
sudo systemctl stop lmstudio

# Restart the service
sudo systemctl restart lmstudio

# Disable auto-start
sudo systemctl disable lmstudio
```

## Community

Chat with other LM Studio developers, discuss LLMs, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).

Please report bugs and issues in the [lmstudio-bug-tracker](https://github.com/lmstudio-ai/lmstudio-bug-tracker/issues) GitHub repository.
