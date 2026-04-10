---
title: Use MCP Servers
description: Connect MCP servers to LM Studio
index: 1
---

Starting LM Studio 0.3.17, LM Studio acts as an **Model Context Protocol (MCP) Host**. This means you can connect MCP servers to the app and make them available to your models.

### Be cautious

Never install MCPs from untrusted sources.

```lms_warning
Some MCP servers can run arbitrary code, access your local files, and use your network connection. Always be cautious when installing and using MCP servers. If you don't trust the source, don't install it.
```

# Use MCP servers in LM Studio

Starting 0.3.17 (b10), LM Studio supports both local and remote MCP servers. You can add MCPs by editing the app's `mcp.json` file or via the ["Add to LM Studio" Button](mcp/deeplink), when available. LM Studio currently follows Cursor's `mcp.json` notation.

## Install new servers: `mcp.json`

Switch to the "Program" tab in the right hand sidebar. Click `Install > Edit mcp.json`.

<img src="/assets/docs/install-mcp.png"  data-caption="" style="width: 80%;" className="" />

This will open the `mcp.json` file in the in-app editor. You can add MCP servers by editing this file.

<img src="/assets/docs/mcp-editor.png"  data-caption="Edit mcp.json using the in-app editor" style="width: 100%;" className="" />

### Example MCP to try: Hugging Face MCP Server

This MCP server provides access to functions like model and dataset search.

<div className="w-fit">
  <a style="background: rgb(255,255,255)" href="https://lmstudio.ai/install-mcp?name=hf-mcp-server&config=eyJ1cmwiOiJodHRwczovL2h1Z2dpbmdmYWNlLmNvL21jcCIsImhlYWRlcnMiOnsiQXV0aG9yaXphdGlvbiI6IkJlYXJlciA8WU9VUl9IRl9UT0tFTj4ifX0%3D">
    <LightVariant>
      <img src="https://files.lmstudio.ai/deeplink/mcp-install-light.svg" alt="Add MCP Server hf-mcp-server to LM Studio" />
    </LightVariant>
    <DarkVariant>
      <img src="https://files.lmstudio.ai/deeplink/mcp-install-dark.svg" alt="Add MCP Server hf-mcp-server to LM Studio" />
    </DarkVariant>
  </a>
</div>

```json
{
  "mcpServers": {
    "hf-mcp-server": {
      "url": "https://huggingface.co/mcp",
      "headers": {
        "Authorization": "Bearer <YOUR_HF_TOKEN>"
      }
    }
  }
}
```

###### You will need to replace `<YOUR_HF_TOKEN>` with your actual Hugging Face token. Learn more [here](https://huggingface.co/docs/hub/en/security-tokens).

Use the [deeplink button](mcp/deeplink), or copy the JSON snippet above and paste it into your `mcp.json` file.

---

## Gotchas and Troubleshooting

- Never install MCP servers from untrusted sources. Some MCPs can have far reaching access to your system.

- Some MCP servers were designed to be used with Claude, ChatGPT, Gemini and might use excessive amounts of tokens.

  - Watch out for this. It may quickly bog down your local model and trigger frequent context overflows.

- When adding MCP servers manually, copy only the content after `"mcpServers": {` and before the closing `}`.
