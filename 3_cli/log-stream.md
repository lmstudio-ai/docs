---
title: "`lms log stream`"
sidebar_title: "`lms log stream`"
description: Stream logs from LM Studio. Useful for debugging prompts sent to the model.
index: -1
---

`lms log stream` allows you to inspect the exact input string that goes to the model.

This is particularly useful for debugging prompt template issues and other unexpected LLM behaviors.

<hr>

```lms_protip
If you haven't already, bootstrap `lms` on your machine by following the instructions [here](/docs/cli).
```

### Debug your prompts with `lms log stream`

`lms log stream` allows you to inspect the exact input string that goes to the model.

Open a terminal and run the following command:

```shell
lms log stream
```

This will start streaming logs from LM Studio. Send a message in the Chat UI or send a request to the local server to see the logs.

### Example output

```bash
$ lms log stream
I Streaming logs from LM Studio

timestamp: 5/2/2024, 9:49:47 PM
type: llm.prediction.input
modelIdentifier: TheBloke/TinyLlama-1.1B-1T-OpenOrca-GGUF/tinyllama-1.1b-1t-openorca.Q2_K.gguf
modelPath: TheBloke/TinyLlama-1.1B-1T-OpenOrca-GGUF/tinyllama-1.1b-1t-openorca.Q2_K.gguf
input: "Below is an instruction that describes a task. Write a response that appropriately completes the request.
### Instruction:
Hello, what's your name?
### Response:
"
```
