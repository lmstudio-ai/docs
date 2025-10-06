---
title: "List your models"
description: "Get a list of available models on your system"
index: 3
---
## List your models

Retrieve a list of all models available on your system.

````lms_hstack
`GET /api/v1/models`

**Request body**
```lms_params
```
:::split:::
```lms_code_snippet
title: Example Request
variants:
  curl:
    language: bash
    code: |
      curl http://127.0.0.1:1234/api/v1/models
```
````

---

````lms_hstack
**Response fields**
```lms_params
- name: models
  type: array<object>
  description: List of available models.
  children:
    - name: id
      type: string
      description: Model identifier.
    - name: name
      type: string
      description: Human-readable model name.
```
:::split:::
```lms_code_snippet
title: Response
variants:
  json:
    language: json
    code: |
      {
        "models": [
          {
            "id": "openai/gpt-oss-20b",
            "name": "GPT-OSS 20B"
          }
        ]
      }
```
````
