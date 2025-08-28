---
title: "Handling Aborts"
+description: "Gracefully handle user-aborted generations in your prompt preprocessor"
index: 5
---

```lms_private_beta
Plugin support is currently in private beta. [Join the beta here](https://forms.gle/ZPfGLMvVC6DbSRQm9).
```

A prediction may be aborted by the user while your generator is still running. In such cases, you should handle the abort gracefully by handling the `ctl.abortSignal`.

You can learn more about `AbortSignal` in the [MDN documentation](https://developer.mozilla.org/en-US/docs/Web/API/AbortSignal).
