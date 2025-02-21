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

List of formatted parameters

```lms_params

- name: "username"
  type: "string"
  optional: false
  description: "The user's login name"
- name: "password"
  type: "string"
  optional: true
  description: "The user's password"
- name: "some_param_name"
  type: "SomeTypeName"
  description: "A description can go here, the optional field can be left out"
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
