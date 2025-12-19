---
title: "Unload a model"
description: "Unload a loaded model from memory"
fullPage: true
index: 8
api_info:
  method: POST
---
````lms_hstack
`POST /api/v1/models/unload`

**Request body**
```lms_params
- name: instance_id
  type: string
  optional: false
  description: Unique identifier of the model instance to unload.
```
:::split:::
```lms_code_snippet
title: Example Request
variants:
  curl:
    language: bash
    code: |
      curl http://localhost:1234/api/v1/models/unload \
        -H "Authorization: Bearer $LM_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "instance_id": "openai/gpt-oss-20b"
        }'
```
````

---

````lms_hstack
**Response fields**
```lms_params
- name: instance_id
  type: string
  description: Unique identifier for the unloaded model instance.
```
:::split:::
```lms_code_snippet
title: Response
variants:
  json:
    language: json
    code: |
      {
        "instance_id": "openai/gpt-oss-20b"
      }
```
````
