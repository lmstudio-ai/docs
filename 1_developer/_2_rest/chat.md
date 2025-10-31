---
title: "Chat with a model"
description: "Send a message to a model and receive a response. Supports MCP integration."
fullPage: true
index: 5
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
      unstyledName: true
      type: string
      description: Unique identifier of a plugin to use. Plugins contain `mcp.json` installed MCP servers (id `mcp/<server_label>`). Shorthand for plugin object with no custom configuration.
    - name: Plugin
      unstyledName: true
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
      unstyledName: true
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
  description: Whether to store the chat. If set, response will return a `"response_id"` field. Default `true`.
- name: previous_response_id
  type: string
  optional: true
  description: Identifier of existing response to append to. Must start with `"resp_"`.
```
:::split:::
```lms_code_snippet
title: Example Request
variants:
  curl:
    language: bash
    code: |
      curl http://localhost:1234/api/v1/chat \
        -H "Authorization: Bearer $LM_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "model": "qwen/qwen3-8b",
          "input": "Tell me the top trending model on hugging face and navigate to https://lmstudio.ai",
          "integrations": [
            {
              "type": "ephemeral_mcp",
              "server_label": "huggingface",
              "server_url": "https://huggingface.co/mcp",
              "allowed_tools": [
                "model_search"
              ]
            },
            {
              "type": "plugin",
              "id": "mcp/playwright",
              "allowed_tools": [
                "browser_navigate"
              ]
            }
          ],
          "context_length": 8000,
          "temperature": 0
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
      unstyledName: true
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
      unstyledName: true
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
              type: '"plugin" | "ephemeral_mcp"'
              description: Provider type.
            - name: plugin_id
              type: string
              optional: true
              description: Identifier of the plugin (when `type` is `"plugin"`).
            - name: server_label
              type: string
              optional: true
              description: Label of the MCP server (when `type` is `"ephemeral_mcp"`).
    - name: Reasoning
      unstyledName: true
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
      description: Number of input tokens. Includes formatting, tool definitions, and prior messages in the chat.
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
    - name: model_load_time_seconds
      type: number
      optional: true
      description: Time taken to load the model for this request in seconds. Present only if the model was not already loaded.
- name: response_id
  type: string
  optional: true
  description: Identifier of the response for subsequent requests. Starts with `"resp_"`. Present when `store` is `true`.
```
:::split:::
```lms_code_snippet
title: Response
variants:
  json:
    language: json
    code: |
      {
        "model_instance_id": "qwen3/qwen3-8b",
        "output": [
          {
            "type": "reasoning",
            "content": "..."
          },
          {
            "type": "tool_call",
            "tool": "model_search",
            "arguments": {
              "sort": "trendingScore",
              "limit": 1
            },
            "output": "...",
            "provider_info": {
              "server_label": "huggingface",
              "type": "ephemeral_mcp"
            }
          },
          {
            "type": "reasoning",
            "content": "We need to navigate."
          },
          {
            "type": "tool_call",
            "tool": "browser_navigate",
            "arguments": {
              "url": "https://hf.co/...."
            },
            "output": "<PLAYWRIGHT_OUTPUT>",
            "provider_info": {
              "plugin_id": "mcp/playwright",
              "type": "plugin"
            }
          },
          {
            "type": "message",
            "content": "Here is the page for the current top‑trending model..."
          }
        ],
        "stats": {
          "input_tokens": 359,
          "total_output_tokens": 218,
          "reasoning_output_tokens": 24,
          "tokens_per_second": 41.097718386623356,
          "time_to_first_token_seconds": 1.367
        },
        "response_id": "resp_46665e1bd0ca7f261ef77344c7ee4b8b969e66c417fbf443"
      }
```
````
