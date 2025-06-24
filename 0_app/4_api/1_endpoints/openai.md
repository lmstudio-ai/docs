---
title: OpenAI Compatibility API
description: Send requests to Chat Completions (text and images), Completions, and Embeddings endpoints
index: 1
---

Send requests to Chat Completions (text and images), Completions, and Embeddings endpoints.

<hr>

### OpenAI-like API endpoints

LM Studio accepts requests on several OpenAI endpoints and returns OpenAI-like response objects.

#### Supported endpoints

```
GET  /v1/models
POST /v1/chat/completions
POST /v1/embeddings
POST /v1/completions
```

###### See below for more info about each endpoint

<hr>

### Re-using an existing OpenAI client

```lms_protip
You can reuse existing OpenAI clients (in Python, JS, C#, etc) by switching up the "base URL" property to point to your LM Studio instead of OpenAI's servers.
```

#### Switching up the `base url` to point to LM Studio

###### Note: The following examples assume the server port is `1234`

##### Python

```diff
from openai import OpenAI

client = OpenAI(
+    base_url="http://localhost:1234/v1"
)

# ... the rest of your code ...
```

##### Typescript

```diff
import OpenAI from 'openai';

const client = new OpenAI({
+  baseUrl: "http://localhost:1234/v1"
});

// ... the rest of your code ...
```

##### cURL

```diff
- curl https://api.openai.com/v1/chat/completions \
+ curl http://localhost:1234/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
-     "model": "gpt-4o-mini",
+     "model": "use the model identifier from LM Studio here",
     "messages": [{"role": "user", "content": "Say this is a test!"}],
     "temperature": 0.7
   }'
```

<hr>

### Endpoints overview

#### `/v1/models`

- `GET` request
- Lists the currently **loaded** models.

##### cURL example

```bash
curl http://localhost:1234/v1/models
```

#### `/v1/chat/completions`

- `POST` request
- Send a chat history and receive the assistant's response
- Prompt template is applied automatically
- You can provide inference parameters such as temperature in the payload. See [supported parameters](#supported-payload-parameters)
- See [OpenAI's documentation](https://platform.openai.com/docs/api-reference/chat) for more information
- As always, keep a terminal window open with [`lms log stream`](/docs/cli/log-stream) to see what input the model receives

##### Python example

```python
# Example: reuse your existing OpenAI setup
from openai import OpenAI

# Point to the local server
client = OpenAI(base_url="http://localhost:1234/v1", api_key="lm-studio")

completion = client.chat.completions.create(
  model="model-identifier",
  messages=[
    {"role": "system", "content": "Always answer in rhymes."},
    {"role": "user", "content": "Introduce yourself."}
  ],
  temperature=0.7,
)

print(completion.choices[0].message)
```

#### `/v1/embeddings`

- `POST` request
- Send a string or array of strings and get an array of text embeddings (integer token IDs)
- See [OpenAI's documentation](https://platform.openai.com/docs/api-reference/embeddings) for more information

##### Python example

```python
# Make sure to `pip install openai` first
from openai import OpenAI
client = OpenAI(base_url="http://localhost:1234/v1", api_key="lm-studio")

def get_embedding(text, model="model-identifier"):
   text = text.replace("\n", " ")
   return client.embeddings.create(input = [text], model=model).data[0].embedding

print(get_embedding("Once upon a time, there was a cat."))
```

#### `/v1/completions`

```lms_warning
This OpenAI-like endpoint is no longer supported by OpenAI.  LM Studio continues to support it.

Using this endpoint with chat-tuned models might result in unexpected behavior such as extraneous role tokens being emitted by the model.


For best results, utilize a base model.
```

- `POST` request
- Send a string and get the model's continuation of that string
- See [supported payload parameters](#supported-payload-parameters)
- Prompt template will NOT be applied, even if the model has one
- See [OpenAI's documentation](https://platform.openai.com/docs/api-reference/completions) for more information
- As always, keep a terminal window open with [`lms log stream`](/docs/cli/log-stream) to see what input the model receives

<hr>

### Supported payload parameters

For an explanation for each parameter, see https://platform.openai.com/docs/api-reference/chat/create.

```py
model
top_p
top_k
messages
temperature
max_tokens
stream
stop
presence_penalty
frequency_penalty
logit_bias
repeat_penalty
seed
```

<hr>

### Community

Chat with other LM Studio developers, discuss LLMs, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).
