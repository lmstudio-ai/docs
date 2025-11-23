---
title: "`lms clone`"
sidebar_title: "`lms clone`"
description: Clone an artifact from LM Studio Hub to a local folder (beta).
index: 1
---

Use `lms clone` to copy an artifact from LM Studio Hub onto your machine.

### Flags
```lms_params
- name: "<artifact>"
  type: "string"
  optional: false
  description: "Artifact identifier in the form owner/name"
- name: "[path]"
  type: "string"
  optional: true
  description: "Destination folder. Defaults to a new folder named after the artifact."
```

If no path is provided, `lms clone owner/name` creates a folder called `name` in the current directory. The command exits if the target path already exists.

### Clone the latest revision

```shell
lms clone alice/sample-plugin
```

### Clone into a specific directory

```shell
lms clone alice/sample-plugin ./my-folder
```
