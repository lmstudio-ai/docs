---
title: "`Add to LM Studio` Button"
description: Add MCP servers to LM Studio using a deeplink
index: 2
---

You can install MCP servers in LM Studio with one click using a deeplink.

Starting with version 0.3.17 (10), LM Studio can act as an MCP host. Learn more about it [here](../mcp).

---

# Generate your own MCP install link

Enter your MCP JSON entry to generate a deeplink for the `Add to LM Studio` button.

```lms_mcp_deep_link_generator

```

## Try an example

Try to copy and paste the following into the link generator above.

```json
{
  "hf-mcp-server": {
    "url": "https://huggingface.co/mcp",
    "headers": {
      "Authorization": "Bearer <YOUR_HF_TOKEN>"
    }
  }
}
```

### Deeplink format

```bash
lmstudio://add_mcp?name=hf-mcp-server&config=eyJ1cmwiOiJodHRwczovL2h1Z2dpbmdmYWNlLmNvL21jcCIsImhlYWRlcnMiOnsiQXV0aG9yaXphdGlvbiI6IkJlYXJlciA8WU9VUl9IRl9UT0tFTj4ifX0%3D
```

#### Parameters

```lms_params
- name: "lmstudio://"
  type: "protocol"
  description: "The protocol scheme to open LM Studio"
- name: "add_mcp"
  type: "path"
  description: "The action to install an MCP server"
- name: "name"
  type: "query parameter"
  description: "The name of the MCP server to install"
- name: "config"
  type: "query parameter"
  description: "Base64 encoded JSON configuration for the MCP server"
```
