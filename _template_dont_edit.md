---
title: Introduction
description: Quick start
---

Welcome to the LM Studio documentation!

## Code Snippets

Configurations that look good:

1. title + 1 variant
2. no title + 2+ variants

```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        // Multi-line TypeScript code
        function hello() {
          console.log("hey")
          return "world"
        }

    Python:
      language: python
      code: |
        # Multi-line Python code
        def hello():
            print("hey")
            return "world"
```

```lms_code_snippet
  title: "generator.py"
  variants:
    Python:
      language: python
      code: |
        # Multi-line Python code
        def hello():
            print("hey")
            return "world"
```

<br></br>

```lms_hstack

# Column 1

~~~js
console.log("Hello from the code block");
~~~

:::split:::

# Column 2
Second column markdown content here

```

<br><br>

```ts
// index.ts
import { LMStudioClient } from "@lmstudio/sdk";

// Create a client to connect to LM Studio, then load a model
async function main() {
  const client = new LMStudioClient();
  const model = await client.llm.load("meta-llama-3-8b");

  const prediction = model.predict("Once upon a time, there was a");

  for await (const text of prediction) {
    process.stdout.write(text);
  }
}

main();
```

```lms_notice
You can jump to Settings from anywhere in the app by pressing `cmd` + `,` on macOS or `ctrl` + `,` on Windows/Linux.
```

```lms_protip
You can jump to Settings from anywhere in the app by pressing `cmd` + `,` on macOS or `ctrl` + `,` on Windows/Linux.
```

```lms_warning
You can jump to Settings from anywhere in the app by pressing `cmd` + `,` on macOS or `ctrl` + `,` on Windows/Linux.
```

### Params

List of formatted flags

### Flags 

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

## What is LM Studio?

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nunc nec
suscipit ultricies, `code which is inline` nunc nunc ultricies nunc, nec suscipit nunc nunc nec. Nullam.

```lms_download_options
repository: user/model
options:
  - name: "meta-llama-3-8b"
    description: "Meta Llama 3 8B"
    version: "1.0.0"
    size: "1.2 GB"
    download: "https://example.com/meta-llama-3-8b.zip"
    license: "MIT"

  - name: "meta-llama-3-8b"
    description: "Meta Llama 3 8B"
    version: "1.0.0"
    size: "1.2 GB"
    download: "https://example.com/meta-llama-3-8b.zip"
    license: "MIT"
```

<img src="/assets/hero-dark-classic@2x.png" alt="LM Studio" data-caption="Some caption and a [link](https://lmstudio.ai)" />

## Main Features

Some of the main features of LM Studio are:

| Feature       | Description                                                           |
| ------------- | --------------------------------------------------------------------- |
| **Feature 1** | Lorem ipsum dolor sit amet, consectetur adipiscing elit.              |
| **Feature 2** | Nullam auctor, nunc nec suscipit ultricies, nunc nunc ultricies nunc. |
| **Feature 3** | Nec suscipit nunc nunc nec. Nullam.                                   |

## How to use this documentation

This documentation is divided into the following sections:

- **Quick Start**: Get started with LM Studio in minutes.
- **API Reference**: Learn how to use the LM Studio API.
