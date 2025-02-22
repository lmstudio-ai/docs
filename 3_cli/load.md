---
title: "`lms load` Reference"
sidebar_title: "`lms load`"
description: Stream logs from LM Studio. Useful for debugging prompts sent to the model.
index: 2
---

The `lms load` command loads a model into memory. You can optionally set parameters such as context length, GPU offload, and TTL.

### Parameters 
```lms_params
- name: "[path]"
  type: "string"
  optional: true
  description: "The path of the model to load. If not provided, you will be prompted to select one"
- name: "--ttl"
  type: "number"
  optional: true
  description: "If provided, when the model is not used for this number of seconds, it will be unloaded"
- name: "--gpu"
  type: "string"
  optional: true
  description: "How much to offload to the GPU. Values: 0-1, off, max"
- name: "--context-length"
  type: "number"
  optional: true
  description: "The number of tokens to consider as context when generating text"
- name: "--identifier"
  type: "string"
  optional: true
  description: "The identifier to assign to the loaded model for API reference"
```

## Load a model

Load a model into memory by running the following command:

```shell
lms load <model_key>
```

You can find the `model_key` by first running [`lms ls`](/docs/cli/ls) to list your locally downloaded models.

### Set a custom identifier

Optionally, you can assign a custom identifier to the loaded model for API reference:

```shell
lms load <model_key> --identifier "my-custom-identifier"
```

You will then be able to refer to this model by the identifier `my_model` in subsequent commands and API calls (`model` parameter).

### Set context length

You can set the context length when loading a model using the `--context-length` flag:

```shell
lms load <model_key> --context-length 4096
```

This determines how many tokens the model will consider as context when generating text.

### Set GPU offload

Control GPU memory usage with the `--gpu` flag:

```shell
lms load <model_key> --gpu 0.5    # Offload 50% of layers to GPU
lms load <model_key> --gpu max    # Offload all layers to GPU
lms load <model_key> --gpu off    # Disable GPU offloading
```

If not specified, LM Studio will automatically determine optimal GPU usage.

### Set TTL

Set an auto-unload timer with the `--ttl` flag (in seconds):

```shell
lms load <model_key> --ttl 3600   # Unload after 1 hour of inactivity
```

## Operate on a remote LM Studio instance

`lms load` supports the `--host` flag to connect to a remote LM Studio instance. 

```shell
lms load <model_key> --host <host>
```

For this to work, the remote LM Studio instance must be running and accessible from your local machine, e.g. be accessible on the same subnet.