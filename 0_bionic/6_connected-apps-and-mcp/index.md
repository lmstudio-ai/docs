---
title: Connect an App or MCP Server
description: Add an MCP connection and complete bearer-token or OAuth authentication.
index: 1
---

**Connect Apps** lets Bionic use tools provided by a Model Context Protocol (MCP) server. Get the connection details from the app or MCP server you want to use.

Only connect servers you trust. Their tools may read or change data in the connected service or on your computer.

## Add a connection

1. Select **Connect Apps** in the Bionic sidebar.
2. Select **Add New**.
3. In **Add a New App**, enter a **Name**.
4. Choose **STDIO** or **Streamable HTTP**.
5. Enter the connection details.
6. Select **Save**.
7. Turn on the app's switch if it is not already running.

The current **Add New** flow opens the MCP connection form directly. There is no preset app picker in this flow.

## Connect a local STDIO server

Choose **STDIO** for a server launched as a local process.

Enter:

- **Local command**.
- Any required **Arguments**.
- Any required **Environment variables**.
- An optional **Working directory**.

The command runs locally. Review installation instructions and command arguments before saving it.

## Connect a Streamable HTTP server

Choose **Streamable HTTP**, then enter the server **URL** and any required **Headers**.

Under **Authentication**, choose:

- **None** for a server with no authentication.
- **Bearer Token** when the service gives you a token.
- **OAuth** for browser-based sign-in.

For OAuth, leave **OAuth client ID** and **OAuth client secret** empty if the server supports dynamic client registration. Otherwise, enter the credentials provided by the service.

## Authenticate with OAuth

After saving the connection:

1. Select **Authenticate**.
2. Complete the sign-in and authorization in your browser.
3. Return to Bionic.

If the browser page does not open, select **Open sign-in**. Select **Cancel** to stop an authentication attempt, or **Sign out** to remove the current OAuth session.

If the connection fails, see [Troubleshoot MCP Connections and OAuth](/docs/bionic/connected-apps-and-mcp/troubleshooting).
