---
title: Image Input
description: API for passing images as input to the model
index: 2
---

TODO: Python SDK's image preparation API is not yet considered stable

Some models, known as VLMs (Vision-Language Models), can accept images as input. You can pass images to the model using the `.respond()` method.

### Prerequisite: Get a VLM (Vision-Language Model)

If you don't yet have a VLM, you can download a model like `qwen2-vl-2b-instruct` using the following command:

```bash
lms get qwen2-vl-2b-instruct
```

## 1. Instantiate the Model

Connect to LM Studio and obtain a handle to the VLM (Vision-Language Model) you want to use.

```lms_code_snippet
  variants:
    Example:
      language: python
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";
        const client = new LMStudioClient()

        const model = client.llm.model("qwen2-vl-2b-instruct")
```

## 2. Prepare the Image

Use the `client.files.prepareImage()` method to get a handle to the image you can pass to the model.

```lms_code_snippet
  variants:
    Example:
      language: python
      code: |
        const imagePath = "/path/to/image.jpg"; # Replace with the path to your image
        const image = client.files.prepareImage(imagePath)

```

If you only have the image in the form of a base64 string, you can use the `client.files.prepareImage64()` method instead.

```lms_code_snippet
  variants:
    Example:
      language: python
      code: |
        const imageBase64 = "Your base64 string here";
        const image = client.files.prepareImage64(imageBase64)
```

We support JPEG, PNG, and WebP image formats.

## 3. Pass the Image to the Model in `.respond()`

Generate a prediction by passing the image to the model in the `.respond()` method.

```lms_code_snippet
  variants:
    Example:
      language: python
      code: |
        const prediction = llm.respond([
          { role: "user", content: "Describe this image please", images: [image] },
        ])
```
