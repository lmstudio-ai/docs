---
title: "`lms unload`"
sidebar_title: "`lms unload`"
description: Unload one or all models from memory using the command line.
index: 3
---

The `lms unload` command unloads a model from memory. You can optionally specify a model key to unload a specific model, or use the `--all` flag to unload all models.

### Parameters
```lms_params
- name: "[model_key]"
  type: "string"
  optional: true
  description: "The key of the model to unload. If not provided, you will be prompted to select one"
- name: "--all"
  type: "flag"
  optional: true
  description: "Unload all currently loaded models"
- name: "--host"
  type: "string"
  optional: true
  description: "The host address of a remote LM Studio instance to connect to"
```

## Unload a specific model

Unload a single model from memory by running:

```shell
lms unload <model_key>
```

If no model key is provided, you will be prompted to select from currently loaded models.

## Unload all models

To unload all currently loaded models at once:

```shell
lms unload --all
```

## Operate on a remote LM Studio instance

`lms unload` supports the `--host` flag to connect to a remote LM Studio instance:

```shell
lms unload <model_key> --host <host>
```

For this to work, the remote LM Studio instance must be running and accessible from your local machine, e.g. be accessible on the same subnet.