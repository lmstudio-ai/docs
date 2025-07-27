---
title: "`lms push` Reference"
sidebar_title: "`lms push`"
description: Upload a plugin, preset, or `model.yaml` to the LM Studio Hub.
index: 9
---

The `lms push` command packages the contents of the current directory and uploads
it to the LM Studio Hub. You can use it to share presets, plugins, or
[`model.yaml`](http://modelyaml.org) files.

### Parameters
```lms_params
- name: "--overrides"
  type: "string"
  optional: true
  description: "A JSON string of values to override in the manifest or metadata"
- name: "--write-revision"
  type: "flag"
  optional: true
  description: "Write the returned revision number to `manifest.json`"
```

## Upload a Plugin, Preset, or `model.yaml`

Run `lms push` inside the directory that contains your plugin, preset, or `model.yaml` file:

1. Navigate to the directory of your plugin, preset, or `model.yaml` file:
```shell
cd path/to/your/directory
```
2. Run the command:
```shell
lms push
```

The command uploads the artifact and prints the revision number. When used with
`--write-revision`, the revision number is also written to the `manifest.json`
file so you can track revisions in version control.

This command works for [presets](/docs/app/presets),
[plugins](/docs/typescript/plugins), and `model.yaml` files.

### Example Usage with `--overrides`
You can use the `--overrides` parameter to modify the metadata before pushing:

```shell
lms push --overrides '{"description": "new-description"}'
```

