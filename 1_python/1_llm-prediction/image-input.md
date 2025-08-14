---
title: Image Input
description: API for passing images as input to the model
index: 2
---

*Required Python SDK version*: **1.1.0**

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
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        model = lms.llm("qwen2-vl-2b-instruct")

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms

        with lms.Client() as client:
            model = client.llm.model("qwen2-vl-2b-instruct")

    "Python (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        import lmstudio as lms

        async with lms.AsyncClient() as client:
            model = await client.llm.model("qwen2-vl-2b-instruct")

```

## 2. Prepare the Image

Use the `prepare_image()` function or `files` namespace method to
get a handle to the image that can subsequently be passed to the model.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        image_path = "/path/to/image.jpg" # Replace with the path to your image
        image_handle = lms.prepare_image(image_path)

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms

        with lms.Client() as client:
            image_path = "/path/to/image.jpg" # Replace with the path to your image
            image_handle = client.files.prepare_image(image_path)

    "Python (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        import lmstudio as lms

        async with lms.AsyncClient() as client:
            image_path = "/path/to/image.jpg" # Replace with the path to your image
            image_handle = await client.files.prepare_image(image_path)

```

If you only have the raw data of the image, you can supply the raw data directly as a bytes
object without having to write it to disk first. Due to this feature, binary filesystem
paths are *not* supported (as they will be handled as malformed image data rather than as
filesystem paths).

Binary IO objects are also accepted as local file inputs.

The LM Studio server supports JPEG, PNG, and WebP image formats.

## 3. Pass the Image to the Model in `.respond()`

Generate a prediction by passing the image to the model in the `.respond()` method.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms

        image_path = "/path/to/image.jpg" # Replace with the path to your image
        image_handle = lms.prepare_image(image_path)
        model = lms.llm("qwen2-vl-2b-instruct")
        chat = lms.Chat()
        chat.add_user_message("Describe this image please", images=[image_handle])
        prediction = model.respond(chat)

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms

        with lms.Client() as client:
            image_path = "/path/to/image.jpg" # Replace with the path to your image
            image_handle = client.files.prepare_image(image_path)
            model = client.llm.model("qwen2-vl-2b-instruct")
            chat = lms.Chat()
            chat.add_user_message("Describe this image please", images=[image_handle])
            prediction = model.respond(chat)

    "Python (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        import lmstudio as lms

        async with lms.AsyncClient() as client:
            image_path = "/path/to/image.jpg" # Replace with the path to your image
            image_handle = client.files.prepare_image(image_path)
            model = await client.llm.model("qwen2-vl-2b-instruct")
            chat = lms.Chat()
            chat.add_user_message("Describe this image please", images=[image_handle])
            prediction = await model.respond(chat)

```
