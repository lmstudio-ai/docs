---
title: "Setup llmster as a Startup Task on Linux"
sidebar_title: "Linux Startup Task"
description: "TODO"
index: 3
---

`llmster`, LM Studio's headless daemon, can be configured to run on startup. Follow this doc to learn how to set up `llmster` to launch, load a model, and start an HTTP server on startup using `systemctl` on Linux.

## 1. Install the Daemon

```bash
curl -fsSL https://lmstudio.ai/install.sh | bash
```

Verify the installation:

```bash
lms --help
```

## 2. Download a Model

```bash
lms get openai/gpt-oss-20b
```

The output will show the model path. You'll need this for the systemd configuration.

## 3. Manual Test

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

## 4. Create Systemd Service

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

## 5. Enable and Start the Service

```bash
sudo systemctl daemon-reload
sudo systemctl enable lmstudio.service
sudo systemctl start lmstudio.service
```

## 6. Verify

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
