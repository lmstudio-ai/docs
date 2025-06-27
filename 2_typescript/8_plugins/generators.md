---
title: "Generators"
description: "Writing generators for LM Studio plugins using TypeScript"
index: 4
---

```lms_private_beta
Plugin support is currently in private beta. [Join the beta here](https://forms.gle/ZPfGLMvVC6DbSRQm9).
```

Preprocessor is a function that is called upon the user hitting the "Send" button. It receives the user input and can modify it before it reaches the model. If multiple preprocessors are registered, they will be chained together, with each one receiving the output of the previous one.
