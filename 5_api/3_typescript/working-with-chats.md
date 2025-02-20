---
title: Working with Chats
description: How to use Chat class to manage conversations
---

## Overview

`lmstudio.js` includes a Chat class designed to simplify conversation management. A conversation consists of a sequence of messages, where each message has:

- A role ("user", "assistant", or "system") indicating who sent it
- Content that can include text and/or images

While you could manage messages using a simple array, the Chat class provides a more convenient interface with helpful features for common conversation handling tasks.
