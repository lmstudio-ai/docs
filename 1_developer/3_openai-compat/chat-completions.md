---
title: Chat Completions
description: Send a chat history and get the assistant's response.
index: 4
api_info:
  method: POST
---

- Method: `POST`
- Prompt template is applied automatically for chat‑tuned models
- Provide inference parameters (temperature, top_p, etc.) in the payload
- See OpenAI docs: https://platform.openai.com/docs/api-reference/chat
- Tip: keep a terminal open with [`lms log stream`](/docs/cli/serve/log-stream) to inspect model input

##### Python example

```python
from openai import OpenAI
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

### Supported payload parameters

See https://platform.openai.com/docs/api-reference/chat/create for parameter semantics.

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
