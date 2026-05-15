---
title: "lms server start"
sidebar_title: "lms server start"
description: Start the LM Studio local server with customizable port and logging options.
index: 1
---

The `lms server start` command launches the LM Studio local server, allowing you to interact with loaded models via HTTP API calls.

### Flags

```lms_params
- name: "--port"
  type: "number"
  optional: true
  description: "Port to run the server on. If not provided, uses the last used port"
- name: "--cors"
  type: "flag"
  optional: true
  description: "Enable CORS support for web application development. When not set, CORS is disabled"
- name: "--bind"
  type: "string"
  optional: true
  description: "Network address to bind the server to. Use \"0.0.0.0\" to listen on all IPv4 interfaces, or \"127.0.0.1\" (default) for localhost only. Can also be set via the LMS_SERVER_HOST environment variable."
```

## Start the server

Start the server with default settings:

```shell
lms server start
```

### Specify a custom port

Run the server on a specific port:

```shell
lms server start --port 3000
```

### Enable CORS support

For usage with web applications or some VS Code extensions, you may need to enable CORS support:

```shell
lms server start --cors
```

Note that enabling CORS may expose your server to security risks, so use it only when necessary.

### Bind to a network address

To make the server available on your local network, run:

```shell
lms server start --bind 0.0.0.0
```

Any non-`127.0.0.1` bind exposes the server beyond `localhost`. The CLI shows a warning when you do this, and you should use it only on trusted networks.

### Check the server status

See [`lms server status`](/docs/cli/serve/server-status) for more information on checking the status of the server.
