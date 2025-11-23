---
title: "`lms log stream`"
sidebar_title: "`lms log stream`"
description: Stream logs from LM Studio. Useful for debugging prompts sent to the model.
index: 4
---

`lms log stream` lets you inspect the exact strings LM Studio sends to and receives from models, and (new in 0.3.26) stream server logs. This is useful for debugging prompt templates, model IO, and server operations.

<hr>

```lms_protip
If you haven't already, bootstrap `lms` on your machine by following the instructions [here](/docs/cli).
```

### Quick start (model input)

By default, `lms log stream` shows the formatted user message that is sent to the model:

```shell
lms log stream
```

Send a message in Chat or call the local HTTP API to see logs.

### Choose a source

Use `--source` to select which logs to stream:

- `--source model` (default) — model IO
- `--source server` — HTTP API server logs (startup, endpoints, status)

Example (server logs):

```shell
lms log stream --source server
```

### Filter model logs

When streaming `--source model`, filter by direction:

- `--filter input` — formatted user message sent to the model
- `--filter output` — model output (printed after completion)
- `--filter input,output` — both user input and model output

Examples:

```shell
# Only the formatted user input
lms log stream --source model --filter input

# Only the model output (emitted once the message completes)
lms log stream --source model --filter output

# Both directions
lms log stream --source model --filter input,output
```

Note: model output is queued and printed once the message completes.

### JSON output and stats

- Append `--json` to emit machine‑readable JSON logs:

```shell
lms log stream --source model --filter input,output --json
```

- Append `--stats` (model source) to include tokens/sec and related metrics:

```shell
lms log stream --source model --filter output --stats
```

### Example (model input and output)

```bash
$ lms log stream --source model --filter input,output
Streaming logs from LM Studio

timestamp: 9/15/2025, 3:16:39 PM
type: llm.prediction.input
modelIdentifier: gpt-oss-20b-mlx
modelPath: lmstudio-community/gpt-oss-20b-mlx-8bit
input:
<|start|>system<|message|>...<|end|><|start|>user<|message|>hello<|end|><|start|>assistant

timestamp: 9/15/2025, 3:16:40 PM
type: llm.prediction.output
modelIdentifier: gpt-oss-20b-mlx
output:
Hello! 👋 How can I assist you today?
```
