---
title: "`lms login`"
sidebar_title: "`lms login`"
description: Authenticate with LM Studio Hub (beta).
index: 4
---

Use `lms login` to authenticate the CLI with LM Studio Hub.

### Sign in with the browser

```shell
lms login
```

The CLI opens a browser window for authentication. If a browser cannot be opened automatically, copy the printed URL into your browser.

### "CI style" login with pre-authenticated keys

```bash
lms login --with-pre-authenticated-keys \
  --key-id <KEY_ID> \
  --public-key <PUBLIC_KEY> \
  --private-key <PRIVATE_KEY> 
```

### Advanced Flags
```lms_params
- name: "--with-pre-authenticated-keys"
  type: "flag"
  optional: true
  description: "Authenticate using pre-generated keys (CI/CD). Requires --key-id, --public-key, and --private-key."
- name: "--key-id"
  type: "string"
  optional: true
  description: "Key ID to use with --with-pre-authenticated-keys"
- name: "--public-key"
  type: "string"
  optional: true
  description: "Public key to use with --with-pre-authenticated-keys"
- name: "--private-key"
  type: "string"
  optional: true
  description: "Private key to use with --with-pre-authenticated-keys"
```