---
title: "Get download status"
description: "Get the status of model downloads"
fullPage: true
index: 9
api_info:
  method: GET
---

````lms_hstack
`GET /api/v1/models/download/status/:job_id`

**Path parameters**
```lms_params
- name: job_id
  type: string
  optional: false
  description: The unique identifier of the download job. `job_id` is returned by the [download](/docs/developer/rest/download) endpoint when a download is initiated.
```
:::split:::
```lms_code_snippet
title: Example Request
variants:
  curl:
    language: bash
    code: |
      curl -H "Authorization: Bearer $LM_API_TOKEN" \
        http://localhost:1234/api/v1/models/download/status/job_493c7c9ded
```
````

````lms_hstack
**Response fields**

Returns a single download job status object. The response varies based on the download status.

```lms_params
- name: job_id
  type: string
  description: Unique identifier for the download job.
- name: status
  type: '"downloading" | "paused" | "completed" | "failed"'
  description: Current status of the download.
- name: bytes_per_second
  type: number
  optional: true
  description: Current download speed in bytes per second. Present when `status` is `downloading`.
- name: estimated_completion
  type: string
  optional: true
  description: Estimated completion time in ISO 8601 format. Present when `status` is `downloading`.
- name: completed_at
  type: string
  optional: true
  description: Download completion time in ISO 8601 format. Present when `status` is `completed`.
- name: total_size_bytes
  type: number
  optional: true
  description: Total size of the download in bytes.
- name: downloaded_bytes
  type: number
  optional: true
  description: Number of bytes downloaded so far.
- name: started_at
  type: string
  optional: true
  description: Download start time in ISO 8601 format.
```
:::split:::
```lms_code_snippet
title: Response
variants:
  json:
    language: json
    code: |
      {
        "job_id": "job_493c7c9ded",
        "status": "completed",
        "total_size_bytes": 2279145003,
        "downloaded_bytes": 2279145003,
        "started_at": "2025-10-03T15:33:23.496Z",
        "completed_at": "2025-10-03T15:43:12.102Z"
      }
```
````
