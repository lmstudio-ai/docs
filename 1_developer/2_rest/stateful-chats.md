---
title: Stateful Chats
sidebar_title: Stateful Chats
description: Learn how to maintain conversation context across multiple requests
index: 8
---

The `/api/v1/chat` endpoint is stateful by default. This means you don't need to pass the full conversation history in every request — LM Studio automatically stores and manages the context for you.

## How it works

When you send a chat request, LM Studio stores the conversation in a thread and returns a `thread_id` in the response. Use this `thread_id` in subsequent requests to continue the conversation.

```lms_code_snippet
title: Start a new conversation
variants:
  curl:
    language: bash
    code: |
      curl http://127.0.0.1:1234/api/v1/chat \
        -H "Authorization: Bearer $LM_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "model": "qwen/qwen3-4b-2507",
          "input": "My favorite color is blue.",
          "store": true  // true by default
        }'
```

The response includes a `thread_id`:

```lms_info
Every response includes an unique `thread_id` that you can use to reference that specific point in the conversation for future requests. This allows you to branch conversations.
```

```lms_code_snippet
title: Response
variants:
  response:
    language: json
    code: |
      {
        "model_instance_id": "qwen/qwen3-4b-2507",
        "output": [
          {
            "type": "message",
            "content": "That's great! Blue is a beautiful color..."
          }
        ],
        "thread_id": "thread_abc123xyz..."
      }
```

## Continue a conversation

Pass the `thread_id` in your next request to continue the conversation. The model will remember the previous context.



```lms_code_snippet
title: Continue the conversation
variants:
  curl:
    language: bash
    code: |
      curl http://127.0.0.1:1234/api/v1/chat \
        -H "Authorization: Bearer $LM_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "model": "qwen/qwen3-4b-2507",
          "input": "What color did I just mention?",
          "thread_id": "thread_abc123xyz...",
          "store": true  // true by default
        }'
```

The model can reference the previous message without you needing to resend it and will return a new `thread_id` for further continuation.

## Disable stateful storage

If you don't want to store the conversation, set `store` to `false`. The response will not include a `thread_id`.

```lms_code_snippet
title: Stateless chat
variants:
  curl:
    language: bash
    code: |
      curl http://127.0.0.1:1234/api/v1/chat \
        -H "Authorization: Bearer $LM_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "model": "qwen/qwen3-4b-2507",
          "input": "Tell me a joke.",
          "store": false
        }'
```

This is useful for one-off requests where you don't need to maintain context.
