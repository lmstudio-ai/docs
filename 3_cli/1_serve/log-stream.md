---
title: "`lms log stream`"
sidebar_title: "`lms log stream`"
description: Stream logs from LM Studio. Useful for debugging prompts sent to the model.
index: 4
---

`lms log stream` lets you inspect the exact strings LM Studio sends to and receives from models, and (new in 0.3.26) stream server logs. This is useful for debugging prompt templates, model IO, and server operations.

### Flags

```lms_params
- name: "-s, --source"
  type: "string"
  optional: true
  description: "Source of logs: model or server (default: model)"
- name: "--stats"
  type: "flag"
  optional: true
  description: "Print prediction stats when available"
- name: "--filter"
  type: "string"
  optional: true
  description: "Filter for model source: input, output, or both"
- name: "--json"
  type: "flag"
  optional: true
  description: "Output logs as JSON (newline separated)"
```

### Quick start

Stream model IO (default):

```shell
lms log stream
```

Stream server logs:

```shell
lms log stream --source server
```

### Filter model logs

```bash
# Only the formatted user input
lms log stream --source model --filter input

# Only the model output (emitted once the message completes)
lms log stream --source model --filter output

# Both directions
lms log stream --source model --filter input,output
```

### JSON output and stats

Emit JSON:

  ```shell
  lms log stream --source model --filter input,output --json
  ```

Include prediction stats:

  ```shell
  lms log stream --source model --filter output --stats
  ```
