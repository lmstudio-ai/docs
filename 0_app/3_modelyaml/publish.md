---
title: Publish a `model.yaml`
description: Upload your model definition to the LM Studio Hub.
index: 7
---

Share portable models by uploading a [`model.yaml`](./) to your page on the LM Studio Hub.

After you publish a model.yaml to the LM Studio Hub, it will be available for other users to download with `lms get`.

###### Note: `model.yaml` refers to metadata only. This means it does not include the actual model weights.

# Quickstart

The easiest way to get started is by cloning an existing model, modifying it, and then running `lms push`.

For example, you can clone the Qwen 3 8B model:

```shell
lms clone qwen/qwen3-8b
```

This will result in a local copy `model.yaml`, `README` and other metadata files. Importantly, this does NOT download the model weights.

```lms_terminal
$ ls
README.md     manifest.json    model.yaml    thumbnail.png
```

## Change the publisher to your user

The first part in the `model:` field should be the username of the publisher. Change it to a username of a user or organization for which you have write access.

```diff
- model: qwen/qwen3-8b
+ model: your-user-here/qwen3-8b
base:
  - key: lmstudio-community/qwen3-8b-gguf
    sources:
# ... the rest of the file
```

## Sign in

Authenticate with the Hub from the command line:

```shell
lms login
```

The CLI will print an authentication URL. After you approve access, the session token is saved locally so you can publish models.

## Publish your model

Run the push command in the directory containing `model.yaml`:

```shell
lms push
```

The command packages the file, uploads it, and prints a revision number for the new version.

### Override metadata at publish time

Use `--overrides` to tweak fields without editing the file:

```shell
lms push --overrides '{"description": "Qwen 3 8B model"}'
```

## Downloading a model and using it in LM Studio

After publishing, the model appears under your user or organization profile on the LM Studio Hub.

It can then be downloaded with:

```shell
lms get my-user/my-model
```
