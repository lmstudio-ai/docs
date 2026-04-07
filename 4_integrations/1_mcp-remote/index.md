---
title: MCP Integrations
sidebar_title: Introduction
description: Connect external services to LM Studio via MCP.
index: 1
---

LM Studio now supports MCP with OAuth. Seamlessly connect integrations that require authentication without copying tokens or configuring headers. Simply add your integration, log in via browser, and its tools are instantly available to your models in LM Studio.

<img src="/assets/docs/mcp-auth.webp" style="width: 100%;" data-caption="Atlassian MCP logged in and Notion MCP requiring authentication" />

## How it works

When you add an OAuth-backed MCP integration, LM Studio:

1. Opens a browser window to the service's authorization page
2. Stores the token securely after you approve access
3. Makes the server's tools available in chat

From that point on, your model can call tools from that service just like any other MCP server.

---

## Connecting with your own OAuth credentials

Some services require you to bring your own OAuth app, either because they don't support dynamic client registration, or because they need a specific redirect URL whitelisted in their developer portal.

In these cases, add an `auth` object to the server entry in `mcp.json`:

```json
{
  "mcpServers": {
    "oauth-server": {
      "url": "https://api.example.com/mcp",
      "auth": {
        "CLIENT_ID": "TEST_CLIENT_ID",
        "CLIENT_SECRET": "TEST_CLIENT_SECRET"
      }
    }
  }
}
```
