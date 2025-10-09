---
title: "Chat with a model"
description: "Send a chat message to a model and receive a response with optional MCP server integration"
index: 2
---


````lms_hstack
`POST /api/v1/chat`

**Request body**
```lms_params
- name: model
  type: string
  optional: false
  description: Unique identifier for the model to use.
- name: input
  type: string
  optional: false
  description: Message to send to the model.
- name: system_prompt
  type: string
  optional: true
  description: System message that sets model behavior or instructions.
- name: mcp_servers
  type: array<object>
  optional: true
  description: List of remote MCP servers that the model can call.
  children:
    - name: server_label
      type: string
      description: Label to identify the MCP server.
    - name: server_url
      type: string
      optional: true
      description: URL of the remote MCP server.
    - name: allowed_tools
      type: array<string>
      optional: true
      description: List of tool names the model can call from this server.
    - name: headers
      type: object
      optional: true
      description: Custom HTTP headers to send with requests to the server.
- name: stream
  type: boolean
  optional: true
  description: Whether to stream partial outputs via SSE. Default `false`.
- name: temperature
  type: number
  optional: true
  description: Randomness in token selection. 0 is deterministic, higher values increase creativity [0,1].
- name: top_p
  type: number
  optional: true
  description: Minimum cumulative probability for the possible next tokens [0,1].
- name: top_k
  type: integer
  optional: true
  description: Limits next token selection to top-k most probable tokens.
- name: min_p
  type: number
  optional: true
  description: Minimum base probability for a token to be selected for output [0,1].
- name: repeat_penalty
  type: number
  optional: true
  description: Penalty for repeating token sequences. 1 is no penalty, higher values discourage repetition.
- name: max_output_tokens
  type: integer
  optional: true
  description: Maximum number of tokens to generate.
- name: reasoning_effort
  type: string
  optional: true
  description: Reasoning effort level. One of `"low"`, `"medium"`, or `"high"`. Ignored if model does not support it.
- name: enable_thinking
  type: boolean
  optional: true
  description: Whether to enable thinking. Ignored if model does not support it.
- name: context_length
  type: integer
  optional: true
  description: Number of tokens to consider as context. Higher values recommended for MCP usage.
- name: store
  type: boolean
  optional: true
  description: Whether to store the chat/thread. If set, response will return a `"thread_id"` field. Default `true`.
- name: thread_id
  type: string
  optional: true
  description: Identifier of existing thread to append to. Must start with `"thread_"`.
```
:::split:::
```lms_code_snippet
title: Example Request
variants:
  curl:
    language: bash
    code: |
      curl http://127.0.0.1:1234/api/v1/chat \
        -H "Content-Type: application/json" \
        -d '{
          "model": "openai/gpt-oss-20b",
          "input": "What is the first sentence of the tiktoken documentation?",
          "mcp_servers": [
            {
              "server_label": "tiktoken",
              "server_url": "https://gitmcp.io/openai/tiktoken",
              "allowed_tools": ["fetch_tiktoken_documentation"]
            }
          ],
          "reasoning_effort": "low",
          "temperature": 0.7,
          "context_length": 5000
        }'
```
````

---

````lms_hstack
**Response fields**
```lms_params
- name: model_instance_id
  type: string
  description: Unique identifier for the loaded model instance that generated the response.
- name: output
  type: array<object>
  description: Array of output items generated. Each item can be one of three types.
  children:
    - name: type
      type: string
      description: Type of output item. One of `"mcp_call"`, `"message"`, or `"reasoning"`.
    - name: content
      type: string
      optional: true
      description: Text content. Present when `type` is `"message"` or `"reasoning"`.
    - name: server_label
      type: string
      optional: true
      description: Label of the MCP server. Present when `type` is `"mcp_call"`.
    - name: tool
      type: string
      optional: true
      description: Name of the tool called. Present when `type` is `"mcp_call"`.
    - name: arguments
      type: object
      optional: true
      description: Arguments passed to the tool. Present when `type` is `"mcp_call"`.
    - name: output
      type: string
      optional: true
      description: Result returned from the tool. Present when `type` is `"mcp_call"`.
- name: stats
  type: object
  description: Token usage and performance metrics.
  children:
    - name: input_tokens
      type: number
      description: Number of input tokens. Includes formatting and prior messages in the thread.
    - name: total_output_tokens
      type: number
      description: Total number of output tokens generated.
    - name: reasoning_output_tokens
      type: number
      description: Number of tokens used for reasoning.
    - name: tokens_per_second
      type: number
      description: Generation speed in tokens per second.
- name: thread_id
  type: string
  optional: true
  description: Identifier of the thread for subsequent requests. Starts with `"thread_"`. Present when `store` is `true`.
```
:::split:::
```lms_code_snippet
title: Response
variants:
  json:
    language: json
    code: |
      {
        "model_instance_id": "openai/gpt-oss-20b",
        "output": [
          {
            "type": "reasoning",
            "content": "We need to fetch doc from GitHub. Use function."
          },
          {
            "type": "mcp_call",
            "server_label": "tiktoken",
            "tool": "fetch_tiktoken_documentation",
            "arguments": {},
            "output": "[{\"type\":\"text\",\"text\":\"# ⏳ tiktoken\\n\\ntiktoken is a fast [BPE](https://en.wikipedia.org/wiki/Byte_pair_encoding) tokeniser for use with\\nOpenAI's models....}]"
          },
          {
            "type": "message",
            "content": "The first sentence of the tiktoken documentation is:\n\n> "tiktoken is a fast BPE tokeniser for use with OpenAI's models.""
          }
        ],
        "stats": {
          "input_tokens": 159,
          "total_output_tokens": 74,
          "reasoning_output_tokens": 12,
          "tokens_per_second": 43.506416908993025
        },
        "thread_id": "thread_e07fff380975be4d76d7d95bcf2cfb978c79b8baca467e2b"
      }
```
````
