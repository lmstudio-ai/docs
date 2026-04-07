---
title: Popular MCP Integrations
sidebar_title: Popular Integrations
description: Connect popular services to LM Studio via MCP.
index: 2
---
## Linear

Create issues, search projects, update statuses, and more in Linear, directly from LM Studio.


<div className="w-fit">
  <a style="background: rgb(255,255,255)" href="https://lmstudio.ai/install-mcp?name=linear&config=eyJ1cmwiOiJodHRwczovL21jcC5saW5lYXIuYXBwL21jcCJ9">
    <LightVariant>
      <img src="https://files.lmstudio.ai/deeplink/mcp-install-light.svg" alt="Add Linear MCP to LM Studio" />
    </LightVariant>
    <DarkVariant>
      <img src="https://files.lmstudio.ai/deeplink/mcp-install-dark.svg" alt="Add Linear MCP to LM Studio" />
    </DarkVariant>
  </a>
</div>

```json
{
  "mcpServers": {
    "linear": {
      "url": "https://mcp.linear.app/mcp"
    }
  }
}
```


---

## Notion

Search pages, create documents, and read from your Notion workspace.


<div className="w-fit">
  <a style="background: rgb(255,255,255)" href="https://lmstudio.ai/install-mcp?name=notion&config=eyJ1cmwiOiJodHRwczovL21jcC5ub3Rpb24uY29tL21jcCJ9">
    <LightVariant>
      <img src="https://files.lmstudio.ai/deeplink/mcp-install-light.svg" alt="Add Notion MCP to LM Studio" />
    </LightVariant>
    <DarkVariant>
      <img src="https://files.lmstudio.ai/deeplink/mcp-install-dark.svg" alt="Add Notion MCP to LM Studio" />
    </DarkVariant>
  </a>
</div>

```json
{
  "mcpServers": {
    "notion": {
      "url": "https://mcp.notion.com/mcp"
    }
  }
}
```


---

## Atlassian

Work with Jira issues and Confluence pages from within LM Studio.


<div className="w-fit">
  <a style="background: rgb(255,255,255)" href="https://lmstudio.ai/install-mcp?name=atlassian&config=eyJ1cmwiOiJodHRwczovL21jcC5hdGxhc3NpYW4uY29tL21jcCJ9">
    <LightVariant>
      <img src="https://files.lmstudio.ai/deeplink/mcp-install-light.svg" alt="Add Atlassian MCP to LM Studio" />
    </LightVariant>
    <DarkVariant>
      <img src="https://files.lmstudio.ai/deeplink/mcp-install-dark.svg" alt="Add Atlassian MCP to LM Studio" />
    </DarkVariant>
  </a>
</div>

```json
{
  "mcpServers": {
    "atlassian": {
      "url": "https://mcp.atlassian.com/mcp"
    }
  }
}
```


---

## Sentry

Query issues, inspect stack traces, and analyze errors from your Sentry projects.


<div className="w-fit">
  <a style="background: rgb(255,255,255)" href="https://lmstudio.ai/install-mcp?name=sentry&config=eyJ1cmwiOiJodHRwczovL21jcC5zZW50cnkuZGV2L21jcCJ9">
    <LightVariant>
      <img src="https://files.lmstudio.ai/deeplink/mcp-install-light.svg" alt="Add Sentry MCP to LM Studio" />
    </LightVariant>
    <DarkVariant>
      <img src="https://files.lmstudio.ai/deeplink/mcp-install-dark.svg" alt="Add Sentry MCP to LM Studio" />
    </DarkVariant>
  </a>
</div>

```json
{
  "mcpServers": {
    "sentry": {
      "url": "https://mcp.sentry.dev/mcp"
    }
  }
}
```


---

Many more integrations are supported. Any MCP server that uses OAuth or standard HTTP transport can be connected to LM Studio. See [Use MCP Servers](/docs/app/mcp) for how to add custom servers manually via `mcp.json`.
