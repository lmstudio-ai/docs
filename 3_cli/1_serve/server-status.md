---
title: "`lms server status`"
sidebar_title: "`lms server status`"
description: Check the status of your running LM Studio server instance.
index: 2
---

The `lms server status` command displays the current status of the LM Studio local server, including whether it's running and its configuration.

### Flags 
```lms_params
- name: "--json"
  type: "flag"
  optional: true
  description: "Output the status in JSON format"
- name: "--verbose"
  type: "flag"
  optional: true
  description: "Enable detailed logging output"
- name: "--quiet"
  type: "flag"
  optional: true
  description: "Suppress all logging output"
- name: "--log-level"
  type: "string"
  optional: true
  description: "The level of logging to use. Defaults to 'info'"
```

## Check server status

Get the basic status of the server:

```shell
lms server status
```

Example output:
```
The server is running on port 1234.
```

### Example usage

```console
➜  ~ lms server start
Starting server...
Waking up LM Studio service...
Success! Server is now running on port 1234

➜  ~ lms server status
The server is running on port 1234.
```

### JSON output

Get the status in machine-readable JSON format:

```shell
lms server status --json --quiet
```

Example output:
```json
{"running":true,"port":1234}
```

### Control logging output

Adjust logging verbosity:

```shell
lms server status --verbose
lms server status --quiet
lms server status --log-level debug
```

You can only use one logging control flag at a time (`--verbose`, `--quiet`, or `--log-level`).
