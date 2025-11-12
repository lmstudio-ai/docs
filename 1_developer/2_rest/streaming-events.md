---
title: "Streaming events"
description: "When you chat with a model with `stream` set to `true`, the response is sent as a stream of events using Server-Sent Events (SSE)."
index: 4
---

Streaming events let you render chat responses incrementally over Server‑Sent Events (SSE). When you call `POST /api/v1/chat` with `stream: true`, the server emits a series of named events that you can consume. These events arrive in order and may include multiple deltas (for reasoning and message content), tool call boundaries and payloads, and any errors encountered. The stream always begins with `chat.start` and concludes with `chat.end`, which contains the aggregated result equivalent to a non‑streaming response.

List of event types that can be sent in an `/api/v1/chat` response stream:
- `chat.start`
- `model_load.start`
- `model_load.progress`
- `model_load.end`
- `prompt_processing.start`
- `prompt_processing.progress`
- `prompt_processing.end`
- `reasoning.start`
- `reasoning.delta`
- `reasoning.end`
- `tool_call.start`
- `tool_call.arguments`
- `tool_call.success`
- `tool_call.failure`
- `message.start`
- `message.delta`
- `message.end`
- `error`
- `chat.end`

Events will be streamed out in the following raw format:
```bash
event: <event type>
data: <JSON event data>
```

### `chat.start`
````lms_hstack
An event that is emitted at the start of a chat response stream.
```lms_params
- name: model_instance_id
  type: string
  description: Unique identifier for the loaded model instance that will generate the response.
- name: type
  type: '"chat.start"'
  description: The type of the event. Always `chat.start`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "chat.start",
        "model_instance_id": "openai/gpt-oss-20b"
      }
```
````

### `model_load.start`
````lms_hstack
Signals the start of a model being loaded to fulfill the chat request. Will not be emitted if the requested model is already loaded.
```lms_params
- name: model_instance_id
  type: string
  description: Unique identifier for the model instance being loaded.
- name: type
  type: '"model_load.start"'
  description: The type of the event. Always `model_load.start`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "model_load.start",
        "model_instance_id": "openai/gpt-oss-20b"
      }
```
````

### `model_load.progress`
````lms_hstack
Progress of the model load.
```lms_params
- name: model_instance_id
  type: string
  description: Unique identifier for the model instance being loaded.
- name: progress
  type: number
  description: Progress of the model load as a float between `0` and `1`.
- name: type
  type: '"model_load.progress"'
  description: The type of the event. Always `model_load.progress`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "model_load.progress",
        "model_instance_id": "openai/gpt-oss-20b",
        "progress": 0.65
      }
```
````

### `model_load.end`
````lms_hstack
Signals a successfully completed model load.
```lms_params
- name: model_instance_id
  type: string
  description: Unique identifier for the model instance that was loaded.
- name: load_time_seconds
  type: number
  description: Time taken to load the model in seconds.
- name: type
  type: '"model_load.end"'
  description: The type of the event. Always `model_load.end`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "model_load.end",
        "model_instance_id": "openai/gpt-oss-20b",
        "load_time_seconds": 12.34
      }
```
````

### `prompt_processing.start`
````lms_hstack
Signals the start of the model processing a prompt.
```lms_params
- name: type
  type: '"prompt_processing.start"'
  description: The type of the event. Always `prompt_processing.start`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "prompt_processing.start"
      }
```
````

### `prompt_processing.progress`
````lms_hstack
Progress of the model processing a prompt.
```lms_params
- name: progress
  type: number
  description: Progress of the prompt processing as a float between `0` and `1`.
- name: type
  type: '"prompt_processing.progress"'
  description: The type of the event. Always `prompt_processing.progress`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "prompt_processing.progress",
        "progress": 0.5
      }
```
````

### `prompt_processing.end`
````lms_hstack
Signals the end of the model processing a prompt.
```lms_params
- name: type
  type: '"prompt_processing.end"'
  description: The type of the event. Always `prompt_processing.end`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "prompt_processing.end"
      }
```
````

### `reasoning.start`
````lms_hstack
Signals the model is starting to stream reasoning content.
```lms_params
- name: type
  type: '"reasoning.start"'
  description: The type of the event. Always `reasoning.start`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "reasoning.start"
      }
```
````

### `reasoning.delta`
````lms_hstack
A chunk of reasoning content. Multiple deltas may arrive.
```lms_params
- name: content
  type: string
  description: Reasoning text fragment.
- name: type
  type: '"reasoning.delta"'
  description: The type of the event. Always `reasoning.delta`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "reasoning.delta",
        "content": "Need to"
      }
```
````

### `reasoning.end`
````lms_hstack
Signals the end of the reasoning stream.
```lms_params
- name: type
  type: '"reasoning.end"'
  description: The type of the event. Always `reasoning.end`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "reasoning.end"
      }
```
````

### `tool_call.start`
````lms_hstack
Emitted when the model starts a tool call.
```lms_params
- name: tool
  type: string
  description: Name of the tool being called.
- name: provider_info
  type: object
  description: Information about the tool provider. Discriminated union upon possible provider types.
  children:
    - name: Plugin provider info
      type: object
      description: Present when the tool is provided by a plugin.
      children:
        - name: type
          type: '"plugin"'
          description: Provider type.
        - name: plugin_id
          type: string
          description: Identifier of the plugin.
    - name: Ephemeral MCP provider info
      type: object
      description: Present when the tool is provided by a ephemeral MCP server.
      children:
        - name: type
          type: '"ephemeral_mcp"'
          description: Provider type.
        - name: server_label
          type: string
          description: Label of the MCP server.
- name: type
  type: '"tool_call.start"'
  description: The type of the event. Always `tool_call.start`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "tool_call.start",
        "tool": "model_search",
        "provider_info": {
          "type": "ephemeral_mcp",
          "server_label": "huggingface"
        }
      }
```
````

### `tool_call.arguments`
````lms_hstack
Arguments streamed for the current tool call.
```lms_params
- name: tool
  type: string
  description: Name of the tool being called.
- name: arguments
  type: object
  description: Arguments passed to the tool. Can have any keys/values depending on the tool definition.
- name: provider_info
  type: object
  description: Information about the tool provider. Discriminated union upon possible provider types.
  children:
    - name: Plugin provider info
      type: object
      description: Present when the tool is provided by a plugin.
      children:
        - name: type
          type: '"plugin"'
          description: Provider type.
        - name: plugin_id
          type: string
          description: Identifier of the plugin.
    - name: Ephemeral MCP provider info
      type: object
      description: Present when the tool is provided by a ephemeral MCP server.
      children:
        - name: type
          type: '"ephemeral_mcp"'
          description: Provider type.
        - name: server_label
          type: string
          description: Label of the MCP server.
- name: type
  type: '"tool_call.arguments"'
  description: The type of the event. Always `tool_call.arguments`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "tool_call.arguments",
        "tool": "model_search",
        "arguments": {
          "sort": "trendingScore",
          "limit": 1
        },
        "provider_info": {
          "type": "ephemeral_mcp",
          "server_label": "huggingface"
        }
      }
```
````

### `tool_call.success`
````lms_hstack
Result of the tool call, along with the arguments used.
```lms_params
- name: tool
  type: string
  description: Name of the tool that was called.
- name: arguments
  type: object
  description: Arguments that were passed to the tool.
- name: output
  type: string
  description: Raw tool output string.
- name: provider_info
  type: object
  description: Information about the tool provider. Discriminated union upon possible provider types.
  children:
    - name: Plugin provider info
      type: object
      description: Present when the tool is provided by a plugin.
      children:
        - name: type
          type: '"plugin"'
          description: Provider type.
        - name: plugin_id
          type: string
          description: Identifier of the plugin.
    - name: Ephemeral MCP provider info
      type: object
      description: Present when the tool is provided by a ephemeral MCP server.
      children:
        - name: type
          type: '"ephemeral_mcp"'
          description: Provider type.
        - name: server_label
          type: string
          description: Label of the MCP server.
- name: type
  type: '"tool_call.success"'
  description: The type of the event. Always `tool_call.success`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "tool_call.success",
        "tool": "model_search",
        "arguments": {
          "sort": "trendingScore",
          "limit": 1
        },
        "output": "[{\"type\":\"text\",\"text\":\"Showing first 1 models...\"}]",
        "provider_info": {
          "type": "ephemeral_mcp",
          "server_label": "huggingface"
        }
      }
```
````


### `tool_call.failure`
````lms_hstack
Indicates that the tool call failed.
```lms_params
- name: reason
  type: string
  description: Reason for the tool call failure.
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
- name: type
  type: '"tool_call.failure"'
  description: The type of the event. Always `tool_call.failure`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "tool_call.failure",
        "reason": "Cannot find tool with name open_browser.",
        "metadata": {
          "type": "invalid_name",
          "tool_name": "open_browser"
        }
      }
```
````

### `message.start`
````lms_hstack
Signals the model is about to stream a message.
```lms_params
- name: type
  type: '"message.start"'
  description: The type of the event. Always `message.start`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "message.start"
      }
```
````

### `message.delta`
````lms_hstack
A chunk of message content. Multiple deltas may arrive.
```lms_params
- name: content
  type: string
  description: Message text fragment.
- name: type
  type: '"message.delta"'
  description: The type of the event. Always `message.delta`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "message.delta",
        "content": "The current"
      }
```
````

### `message.end`
````lms_hstack
Signals the end of the message stream.
```lms_params
- name: type
  type: '"message.end"'
  description: The type of the event. Always `message.end`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "message.end"
      }
```
````

### `error`
````lms_hstack
An error occurred during streaming. The final payload will still be sent in `chat.end` with whatever was generated.
```lms_params
- name: error
  type: object
  description: Error information.
  children:
    - name: type
      type: '"invalid_request" | "unknown" | "mcp_connection_error" | "plugin_connection_error" | "not_implemented" | "model_not_found" | "job_not_found" | "internal_error"'
      description: High-level error type.
    - name: message
      type: string
      description: Human-readable error message.
    - name: code
      type: string
      optional: true
      description: More detailed error code (e.g., validation issue code).
    - name: param
      type: string
      optional: true
      description: Parameter associated with the error, if applicable.
- name: type
  type: '"error"'
  description: The type of the event. Always `error`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "error",
        "error": {
          "type": "invalid_request",
          "message": "\"model\" is required",
          "code": "missing_required_parameter",
          "param": "model"
        }
      }
```
````

### `chat.end`
````lms_hstack
Final event containing the full aggregated response, equivalent to the non-streaming `POST /api/v1/chat` response body.
```lms_params
- name: result
  type: object
  description: Final response with `model_instance_id`, `output`, `stats`, and optional `response_id`. See [non-streaming chat docs](/docs/developer/rest/chat) for more details.
- name: type
  type: '"chat.end"'
  description: The type of the event. Always `chat.end`.
```
:::split:::
```lms_code_snippet
title: Example Event Data
variants:
  json:
    language: json
    code: |
      {
        "type": "chat.end",
        "result": {
          "model_instance_id": "openai/gpt-oss-20b",
          "output": [
            { "type": "reasoning", "content": "Need to call function." },
            {
              "type": "tool_call",
              "tool": "model_search",
              "arguments": { "sort": "trendingScore", "limit": 1 },
              "output": "[{\"type\":\"text\",\"text\":\"Showing first 1 models...\"}]",
              "provider_info": { "type": "ephemeral_mcp", "server_label": "huggingface" }
            },
            { "type": "message", "content": "The current top‑trending model is..." }
          ],
          "stats": {
            "input_tokens": 329,
            "total_output_tokens": 268,
            "reasoning_output_tokens": 5,
            "tokens_per_second": 43.73,
            "time_to_first_token_seconds": 0.781
          },
          "response_id": "resp_02b2017dbc06c12bfc353a2ed6c2b802f8cc682884bb5716"
        }
      }
```
````
