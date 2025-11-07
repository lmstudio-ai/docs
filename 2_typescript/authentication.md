---
title: Authentication
sidebar_title: Authentication
description: Using API Tokens in LM Studio
index: 2
---

##### Requires [LM Studio 0.4.0](/download) or newer.

LM Studio supports API Tokens for authentication, providing a secure and convenient way to access the LM Studio API.

By default, the LM Studio API runs **without enforcing authentication**. For production or shared environments, enable API Token authentication for secure access.

```lms_info
To enable API Token authentication, create tokens and control granular permissions, check [this guide](/docs/developer/core/authentication) for more details.
```

## Providing the API Token

There are two ways to provide the API Token when creating an instance of `LMStudioClient`:

1. **Environment Variable (Recommended)**: Set the `LM_API_TOKEN` environment variable, and the SDK will automatically read it.
2. **Function Argument**: Pass the token directly as the `apiToken` parameter in the constructor.

```lms_code_snippet
  variants:
    Environment Variable:
      language: typescript
      code: |
        // Set environment variables in your terminal before running the code:
        // export LM_API_TOKEN="your-token-here"

        import { LMStudioClient } from "@lmstudio/sdk";
        // The SDK automatically reads from LM_API_TOKEN environment variable
        const client = new LMStudioClient();

        const model = await client.llm.model("qwen/qwen3-4b-2507");
        const result = await model.respond("What is the meaning of life?");

        console.info(result.content);
    Function Argument:
      language: typescript
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";
        const client = new LMStudioClient({
          apiToken: "your-token-here",
        });

        const model = await client.llm.model("qwen/qwen3-4b-2507");
        const result = await model.respond("What is the meaning of life?");

        console.info(result.content);
```
