---
title: "`lms server stop`"
sidebar_title: "`lms server stop`"
description: Stop the running LM Studio server instance.
index: 3
---

The `lms server stop` command gracefully stops the running LM Studio server.

```shell
lms server stop
```

Example output:
```
Stopped the server on port 1234.
```

Any active request will be terminated when the server is stopped. You can restart the server using [`lms server start`](/docs/cli/serve/server-start).
