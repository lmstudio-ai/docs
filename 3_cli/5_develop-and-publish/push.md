---
title: "`lms push` (Beta)"
sidebar_title: "`lms push`"
description: Upload the current folder's artifact to LM Studio Hub (beta).
index: 2
---

Run `lms push` from inside a [plugin](/docs/typescript/plugins), [preset](/docs/app/presets), or [`model.yaml`](/docs/app/modelyaml) project to publish a new revision. If a `model.yaml` exists, the CLI will generate a `manifest.json` for you before pushing. 

For plugins, the CLI will ask for confirmation unless you pass `-y`.

### Publish the current folder

```shell
lms push
```

### Flags
```lms_params
- name: "--description"
  type: "string"
  optional: true
  description: "Override the artifact description for this push"
- name: "--overrides"
  type: "string"
  optional: true
  description: "JSON string to override manifest fields (parsed with JSON.parse)"
- name: "-y, --yes"
  type: "flag"
  optional: true
  description: "Suppress confirmations and warnings"
- name: "--private"
  type: "flag"
  optional: true
  description: "Mark the artifact as private when first published"
- name: "--write-revision"
  type: "flag"
  optional: true
  description: "Write the returned revision number to manifest.json"
```


### Advanced 

#### Publish quietly and keep the revision in manifest.json

```shell
lms push -y --write-revision
```

#### Override metadata for this upload

```shell
lms push --description "New beta build" --overrides '{"tags": ["beta"]}'
```
