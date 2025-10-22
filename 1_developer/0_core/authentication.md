---
title: Authentication
sidebar_title: Authentication
description: Using API Tokens in LM Studio
index: 1
---

LM Studio, from version 0.4.0 (REPLACE WITH CORRECT VERSION), supports API Tokens for authentication, providing a secure and convenient way to access the LM Studio API.


### Require Authentication for each request

By default, LM Studio does not require authentication for API requests. To enable authentication so that only requests with a valid API Token are accepted, toggle the switch in the Developers Page > Server Settings.



```lms_info
Once enabled, all requests made through the REST API, Python SDK, or Typescript SDK will need to include a valid API Token. See usage [below](#usage-of-api-tokens)
```

<img src="/assets/docs/require-auth.png" style="width: 75%;" data-caption="Enable authentication to require valid API tokens for all requests" />

<img src="/assets/docs/multiple-tokens.png" style="width: 75%;" data-caption="Managing tokens in the server settings" />



### Creating API Tokens

To create API Tokens, click on Manage Tokens in the Server Settings. It will open the API Tokens modal where you can create, view, and delete API Tokens.

<img src="/assets/docs/tokens-empty-modal.png" style="width: 75%;" data-caption="API Tokens Modal" />

Create a token by clicking on the Create Token button. Provide a name for the token and select the desired permissions.

<img src="/assets/docs/create-dave-token.png" style="width: 75%;" data-caption="Creating an API Token" />

Once created, make sure to copy the token as it will not be shown again.

<img src="/assets/docs/created-dave-token.png" style="width: 75%;" data-caption="API token created" />


### Configuring API Token Permissions

To edit the permissions of an existing API Token, click on the Edit button next to the token in the API Tokens modal. You can modify the name and permissions of the token.

<img src="/assets/docs/edit-token.png" style="width: 75%;" data-caption="Editing an API Token" />


## Usage of API Tokens

### Using API Tokens with REST API:

```lms_noticechill
The example below requires [allowing calling servers from mcp.json](/docs/developer/core/server/settings) to be enabled and the [tiktoken](https://gitmcp.io/openai/tiktoken) plugin in mcp.json.
```


```bash
curl --request POST \
  --url http://localhost:1234/api/v1/chat \
  --header 'authorization: Bearer <GENERATED_API_TOKEN>' \
  --header 'content-type: application/json' \
  --data '{
  "model": "gpt-oss-20b",s
  "input": "What is the first line in the tiktoken documentation?",
  "plugins": [
    {
      "id": "mcp/tiktoken",
      "allowed_tools": [
        "fetch_tiktoken_documentation"
      ]
    }
  ],
  "temperature": 0.7,
  "stream": true
}'
```


### Using API Tokens with Python SDK

To use API tokens with the Python SDK, see the [Python SDK guide](/docs/python/authentication).

### Using API Tokens with TypeScript SDK

To use API tokens with the TypeScript SDK, see the [TS SDK guide](/docs/typescript/authentication).
