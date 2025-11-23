---
title: "`lms import`"
sidebar_title: "`lms import`"
description: Import a local model file into your LM Studio models directory.
index: 6
---

Use `lms import` to bring an existing model file into LM Studio without downloading it.

### Flags 
```lms_params
- name: "<file-path>"
  type: "string"
  optional: false
  description: "Path to the model file to import"
- name: "--user-repo"
  type: "string"
  optional: true
  description: "Set the target folder as <user>/<repo>. Skips the categorization prompts."
- name: "-y, --yes"
  type: "flag"
  optional: true
  description: "Skip confirmations and try to infer the model location from the file name"
- name: "-c, --copy"
  type: "flag"
  optional: true
  description: "Copy the file instead of moving it"
- name: "-L, --hard-link"
  type: "flag"
  optional: true
  description: "Create a hard link instead of moving or copying the file"
- name: "-l, --symbolic-link"
  type: "flag"
  optional: true
  description: "Create a symbolic link instead of moving or copying the file"
- name: "--dry-run"
  type: "flag"
  optional: true
  description: "Do not perform the import, just show what would be done"
```

Only one of `--copy`, `--hard-link`, or `--symbolic-link` can be used at a time. If none is provided, `lms import` moves the file by default.

### Import a model file

```shell
lms import ~/Downloads/model.gguf
```

### Keep the original file

```shell
lms import ~/Downloads/model.gguf --copy
```

### Pick the target folder yourself

Use `--user-repo` to skip prompts and place the model in the chosen namespace:

```shell
lms import ~/Downloads/model.gguf --user-repo my-user/custom-models
```

### Dry run before importing

```shell
lms import ~/Downloads/model.gguf --dry-run
```
