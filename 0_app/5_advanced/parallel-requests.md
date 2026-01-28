---
title: Parallel Requests
description: Enable parallel requests via continuous batching
---


When loading a model, you can now set Max Concurrent Predictions to allow multiple requests to be processed in parallel, instead of queued. This is supported for LM Studio's llama.cpp engine, with MLX coming later.

<hr>

### Parallel Requests via Continuous Batching
Parallel requests via continuous batching allows the LM Studio server to dynamically combine multiple requests into a single GPU batch while previous requests remain running, rather than waiting for fixed batch windows. This enables concurrent workflows and results in higher throughput and lower perceived latency.


### Sending parallel requests through the server


[Insert Example]


### Sending parallel requests to chats in Split View


Use the [split view in chat feature](/docs/basics/chat) to send two requests simultaneously to two chats and view them side by side. 

<img src="/assets/docs/parallel-requests.png" style="width: 500px; margin-top:30px" data-caption="Send parallel requests using split view in chat" />