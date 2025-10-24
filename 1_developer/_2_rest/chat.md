---
title: "Chat with a model"
description: "Send a message to a model and receive a response. Supports MCP integration."
fullPage: true
index: 3
api_info:
  method: POST
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
- name: integrations
  type: array<string | object>
  optional: true
  description: List of integrations (plugins, ephemeral MCP servers, etc...) to enable for this request.
  children:
    - name: Plugin id
      type: string
      description: Unique identifier of a plugin to use. Plugins contain `mcp.json` installed MCP servers (id `mcp/<server_label>`). Shorthand for plugin object with no custom configuration.
    - name: Plugin
      type: object
      description: Specification of a plugin to use. Plugins contain `mcp.json` installed MCP servers (id `mcp/<server_label>`).
      children:
        - name: type
          type: '"plugin"'
          optional: false
          description: Type of integration.
        - name: id
          type: string
          optional: false
          description: Unique identifier of the plugin.
        - name: allowed_tools
          type: array<string>
          optional: true
          description: List of tool names the model can call from this plugin. If not provided, all tools from the plugin are allowed.
    - name: Ephemeral MCP server specification
      type: object
      description: Specification of an ephemeral MCP server. Allows defining MCP servers on-the-fly without needing to pre-configure them in your `mcp.json`.
      children:
        - name: type
          type: '"ephemeral_mcp"'
          optional: false
          description: Type of integration.
        - name: server_label
          type: string
          optional: false
          description: Label to identify the MCP server.
        - name: server_url
          type: string
          optional: false
          description: URL of the MCP server.
        - name: allowed_tools
          type: array<string>
          optional: true
          description: List of tool names the model can call from this server. If not provided, all tools from the server are allowed.
        - name: headers
          type: object
          optional: true
          description: Custom HTTP headers to send with requests to the server.
- name: stream
  type: boolean
  optional: true
  description: Whether to stream partial outputs via SSE. Default `false`. See [streaming events](/docs/developer/rest/streaming-events) for more information.
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
- name: reasoning
  type: '"off" | "low" | "medium" | "high" | "on"'
  optional: true
  description: Reasoning setting. Will error if the model being used does not support the reasoning setting using. Defaults to the automatically chosen setting for the model.
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
        -H "Authorization: Bearer $LM_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "model": "openai/gpt-oss-20b",
          "input": "What is the top trending model on huggingface?",
          "remote_mcp_servers": [
            {
              "server_label": "huggingface",
              "server_url": "https://huggingface.co/mcp",
              "allowed_tools": ["model_search"]
            }
          ]
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
    - name: Message
      type: object
      description: A text message from the model.
      children:
        - name: type
          type: '"message"'
          description: Type of output item.
        - name: content
          type: string
          description: Text content of the message.
    - name: Tool call
      type: object
      description: A tool call made by the model.
      children:
        - name: type
          type: '"tool_call"'
          description: Type of output item.
        - name: tool
          type: string
          description: Name of the tool called.
        - name: arguments
          type: object
          description: Arguments passed to the tool. Can have any keys/values depending on the tool definition.
        - name: output
          type: string
          description: Result returned from the tool.
        - name: provider_info
          type: object
          description: Information about the tool provider.
          children:
            - name: type
              type: '"plugin" | "remote_mcp"'
              description: Provider type.
            - name: plugin_id
              type: string
              optional: true
              description: Identifier of the plugin (when `type` is `"plugin"`).
            - name: server_label
              type: string
              optional: true
              description: Label of the MCP server (when `type` is `"remote_mcp"`).
    - name: Reasoning
      type: object
      description: Reasoning content from the model.
      children:
        - name: type
          type: '"reasoning"'
          description: Type of output item.
        - name: content
          type: string
          description: Text content of the reasoning.
- name: stats
  type: object
  description: Token usage and performance metrics.
  children:
    - name: input_tokens
      type: number
      description: Number of input tokens. Includes formatting, tool definitions, and prior messages in the thread.
    - name: total_output_tokens
      type: number
      description: Total number of output tokens generated.
    - name: reasoning_output_tokens
      type: number
      description: Number of tokens used for reasoning.
    - name: tokens_per_second
      type: number
      description: Generation speed in tokens per second.
    - name: time_to_first_token_seconds
      type: number
      description: Time in seconds to generate the first token.
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
            "content": "Need to call function."
          },
          {
            "type": "tool_call",
            "tool": "model_search",
            "arguments": {
              "sort": "trendingScore",
              "limit": 1
            },
            "output": "[{\"type\":\"text\",\"text\":\"Showing first 1 models...\"}]",
            "provider_info": {
              "type": "remote_mcp"
              "server_label": "huggingface",
            }
          },
          {
            "type": "message",
            "content": "The current top‑trending model is..."
          }
        ],
        "stats": {
          "input_tokens": 329,
          "total_output_tokens": 268,
          "reasoning_output_tokens": 5,
          "tokens_per_second": 43.73263766917279,
          "time_to_first_token_seconds": 0.781
        },
        "thread_id": "thread_02b2017dbc06c12bfc353a2ed6c2b802f8cc682884bb5716"
      }
```
````
