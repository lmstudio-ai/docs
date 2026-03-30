---
title: Parallel Requests
description: Enable parallel requests via continuous batching
---

When loading a model, you can now set Max Concurrent Predictions to allow multiple requests to be processed in parallel, instead of queued. This is supported for LM Studio's llama.cpp engine, with MLX coming soon. 

Please make sure your GGUF runtime is upgraded to llama.cpp v2.0.0.

<hr>

### Parallel Requests via Continuous Batching
Parallel requests via continuous batching allows the LM Studio server to dynamically combine multiple requests into a single batch. This enables concurrent workflows and results in higher throughput.

### Setting Max Concurrent Predictions

Open the model loader and toggle on Manually choose model load parameters. Select a model to load, and toggle on Show advanced settings to set Max Concurrent Predictions. By default, Max Concurrent Predictions is set to 4.

### Sending parallel requests to chats in Split View

Use the [split view in chat feature](/docs/basics/chat) to send two requests simultaneously to two chats and view them side by side. 

<img src="/assets/docs/parallel-requests.png" style="width:80%; margin-top:30px" data-caption="Send parallel requests using split view in chat" />
