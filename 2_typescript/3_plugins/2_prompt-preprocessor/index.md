---
title: "Introduction"
description: "Writing prompt preprocessors for LM Studio plugins using TypeScript"
index: 1
---

Prompt Preprocessor is a function that is called upon the user hitting the "Send" button. It receives the user input and can modify it before it reaches the model. If multiple prompt preprocessors are registered, they will be chained together, with each one receiving the output of the previous one.

The modified result will be saved in the chat history, meaning that even if your plugin is disabled afterwards, the modified input will still be used.

Prompt preprocessors will only be triggered for the current user input. It will not be triggered for previous messages in the chat history even if they were not preprocessed.

Prompt preprocessors takes in a `ctl` object for controlling the preprocessing and a `userMessage` it needs to preprocess. It returns either a string or a message object which will replace the user message.

### Examples

The following are some plugins that make use of prompt preprocessors:

- [lmstudio/rag-v1](https://lmstudio.ai/lmstudio/rag-v1)

  Retrieval Augmented Generation (RAG) for LM Studio. This is the plugin that gives document handling capabilities to LM Studio.
