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
  type: string | array<object>
  optional: false
  description: Message to send to the model.
  children:
    - name: Input text
      unstyledName: true
      type: string
      description: Text content of the message.
    - name: Input object
      unstyledName: true
      type: object
      description: Object representing a message with additional metadata.
      children:
        - name: Text Input
          type: object
          optional: true
          description: Text input to provide user messages
          children:
            - name: type
              type: '"message"'
              optional: false
              description: Type of input item.
            - name: content
              type: string
              description: Text content of the message.
              optional: false
        - name: Image Input
          type: object
          optional: true
          description: Image input to provide user messages
          children:
            - name: type
              type: '"image"'
              optional: false
              description: Type of input item.
            - name: data_url
              type: string
              description: Image data as a base64-encoded data URL.
              optional: false
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
variants:
  Request with MCP:
    language: bash
    code: |
      curl http://localhost:1234/api/v1/chat \
        -H "Authorization: Bearer $LM_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "model": "ibm/granite-4-micro",
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
  Request with Images:
    language: bash
    code: |
      # Image is a small red square encoded as a base64 data URL
      curl http://localhost:1234/api/v1/chat \
        -H "Authorization: Bearer $LM_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "model": "qwen/qwen3-vl-4b",
          "input": [
            {
              "type": "text",
              "content": "Describe this image in two sentences"
            },
            {
              "type": "image",
              "data_url": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAAFUlEQVR42mP8z8BQz0AEYBxVSF+FABJADveWkH6oAAAAAElFTkSuQmCC"
            }
          ],
          "context_length": 2048,
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
    - name: Invalid tool call
      unstyledName: true
      type: object
      description: An invalid tool call made by the model - due to invalid tool name or tool arguments.
      children:
        - name: type
          type: '"invalid_tool_call"'
          description: Type of output item.
        - name: reason
          type: string
          description: Reason why the tool call was invalid.
        - name: metadata
          type: object
          description: Metadata about the invalid tool call.
          children:
            - name: type
              type: '"invalid_name" | "invalid_arguments"'
              description: Type of error that occurred.
            - name: tool_name
              type: string
              description: Name of the tool that was attempted to be called.
            - name: arguments
              type: object
              optional: true
              description: Arguments that were passed to the tool (only present for `invalid_arguments` errors).
            - name: provider_info
              type: object
              optional: true
              description: Information about the tool provider (only present for `invalid_arguments` errors).
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
variants:
  Request with MCP:
    language: json
    code: |
      {
        "model_instance_id": "ibm/granite-4-micro",
        "output": [
          {
            "type": "tool_call",
            "tool": "model_search",
            "arguments": {
              "sort": "trendingScore",
              "query": "",
              "limit": 1
            },
            "output": "...",
            "provider_info": {
              "server_label": "huggingface",
              "type": "ephemeral_mcp"
            }
          },
          {
            "type": "message",
            "content": "..."
          },
          {
            "type": "tool_call",
            "tool": "browser_navigate",
            "arguments": {
              "url": "https://lmstudio.ai"
            },
            "output": "...",
            "provider_info": {
              "plugin_id": "mcp/playwright",
              "type": "plugin"
            }
          },
          {
            "type": "message",
            "content": "**Top Trending Model on Hugging Face** ... Below is a quick snapshot of what’s on the landing page ... more details on the model or LM Studio itself!"
          }
        ],
        "stats": {
          "input_tokens": 646,
          "total_output_tokens": 586,
          "reasoning_output_tokens": 0,
          "tokens_per_second": 29.753900615398926,
          "time_to_first_token_seconds": 1.088,
          "model_load_time_seconds": 2.656
        },
        "response_id": "resp_4ef013eba0def1ed23f19dde72b67974c579113f544086de"
      }
  Request with Images:
    language: json
    code: |
      {
        "model_instance_id": "qwen/qwen3-vl-4b",
        "output": [
          {
            "type": "message",
            "content": "This image is a solid, vibrant red square that fills the entire frame, with no discernible texture, pattern, or other elements. It presents a minimalist, uniform visual field of pure red, evoking a sense of boldness or urgency."
          }
        ],
        "stats": {
          "input_tokens": 17,
          "total_output_tokens": 50,
          "reasoning_output_tokens": 0,
          "tokens_per_second": 51.03762685242662,
          "time_to_first_token_seconds": 0.814
        },
        "response_id": "resp_0182bd7c479d7451f9a35471f9c26b34de87a7255856b9a4"
      }
```
````
