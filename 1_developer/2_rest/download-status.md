---
title: "Get download status"
description: "Get the status of model downloads"
index: 6
---

````lms_hstack
`GET /api/v1/models/download/status`

This endpoint has no request parameters.
:::split:::
```lms_code_snippet
title: Example Request
variants:
  curl:
    language: bash
    code: |
      curl \
        http://127.0.0.1:1234/api/v1/models/download/status
```
````

````lms_hstack
**Response fields**

Returns an object with separate arrays for different download job statuses. The response varies based on the download status.

```lms_params
- name: downloading
  type: array
  description: Array of jobs currently downloading.
  children:
    - name: job_id
      type: string
      description: Unique identifier for the download job.
    - name: status
      type: '"downloading"'
      description: Current status of the download.
    - name: downloaded_bytes
      type: number
      description: Number of bytes downloaded so far.
    - name: total_size_bytes
      type: number
      description: Total size of the download in bytes.
    - name: started_at
      type: string
      optional: true
      description: Download start time in ISO 8601 format.
    - name: bytes_per_second
      type: number
      description: Current download speed in bytes per second.
    - name: estimated_completion
      type: string
      description: Estimated completion time in ISO 8601 format.
- name: completed
  type: array
  description: Array of completed jobs.
  children:
    - name: job_id
      type: string
      description: Unique identifier for the download job.
    - name: status
      type: '"completed"'
      description: Current status of the download.
    - name: downloaded_bytes
      type: number
      description: Number of bytes downloaded so far.
    - name: total_size_bytes
      type: number
      description: Total size of the download in bytes.
    - name: started_at
      type: string
      optional: true
      description: Download start time in ISO 8601 format.
    - name: completed_at
      type: string
      description: Download completion time in ISO 8601 format.
- name: failed
  type: array
  description: Array of failed jobs.
  children:
    - name: job_id
      type: string
      description: Unique identifier for the download job.
    - name: status
      type: '"failed"'
      description: Current status of the download.
    - name: downloaded_bytes
      type: number
      description: Number of bytes downloaded so far.
    - name: total_size_bytes
      type: number
      description: Total size of the download in bytes.
    - name: started_at
      type: string
      optional: true
      description: Download start time in ISO 8601 format.
- name: paused
  type: array
  description: Array of paused jobs.
  children:
    - name: job_id
      type: string
      description: Unique identifier for the download job.
    - name: status
      type: '"paused"'
      description: Current status of the download.
    - name: downloaded_bytes
      type: number
      description: Number of bytes downloaded so far.
    - name: total_size_bytes
      type: number
      description: Total size of the download in bytes.
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
        "downloading": [
          {
            "job_id": "job_c0b7159ee6",
            "downloaded_bytes": 2423265340,
            "total_size_bytes": 124196907504,
            "started_at": "2025-10-06T18:43:08.019Z",
            "bytes_per_second": 9834240.879725136,
            "estimated_completion": "2025-10-06T22:24:29.908Z",
            "status": "downloading"
          }
        ],
        "completed": [],
        "failed": [],
        "paused": [
          {
            "job_id": "job_222ebe6763",
            "downloaded_bytes": 12028808,
            "total_size_bytes": 22256526743,
            "started_at": "2025-10-06T18:43:53.605Z",
            "status": "paused"
          }
        ]
      }
```
````

---

````lms_hstack
`GET /api/v1/models/download/status/:job_id`

**Path parameters**
```lms_params
- name: job_id
  type: string
  optional: false
  description: The unique identifier of the download job.
```
:::split:::
```lms_code_snippet
title: Example Request
variants:
  curl:
    language: bash
    code: |
      curl \
        http://127.0.0.1:1234/api/v1/models/download/status/job_493c7c9ded
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
