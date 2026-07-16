---
title: Troubleshoot MCP Connections and OAuth
description: Fix MCP server startup, configuration, bearer-token, and OAuth problems.
index: 2
---

Open **Connect Apps** and select the connection. Its status shows whether the server is off, starting, stopped, connected, or reporting an error.

## The server does not start

Turn the connection off, check its settings, then turn it on again.

For **STDIO**, check:

- **Local command** points to an installed executable.
- **Arguments** are in the expected order.
- Required **Environment variables** are present.
- **Working directory** exists and is accessible.

For **Streamable HTTP**, check the **URL** and any required **Headers**. Confirm that the server is available from your device.

A connected server shows its available tool count. If it stops, open the connection to view the reported error.

## Authentication is required

For a bearer-token connection, check that the token is current and was entered under **Bearer Token**.

For OAuth, select **Authenticate**. If Bionic is waiting for browser authorization, select **Open sign-in**, finish the flow, and return to Bionic.

## OAuth registration fails

Some MCP servers support dynamic client registration. For those servers, leave **OAuth client ID** and **OAuth client secret** empty.

If the server does not support dynamic registration, enter the client ID and secret supplied by the service. Check the server's setup instructions for its required redirect and client configuration.

## OAuth still does not connect

1. Select **Cancel** if an old authentication attempt is still active.
2. Select **Sign out** if the connection has stale credentials.
3. Check the URL, headers, and OAuth credentials.
4. Select **Authenticate** and complete sign-in again.

If you change the connection settings, save them before retrying.

For setup steps, see [Connect an App or MCP Server](/docs/bionic/connected-apps-and-mcp).
