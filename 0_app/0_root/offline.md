---
title: Offline Operation
description: LM Studio can operate entirely offline, just make sure to get some model files first.
index: 4
---

```lms_notice
In general, LM Studio does not require the internet in order to work. This includes core functions like chatting with models, chatting with documents, or running a local server, none of which require the internet.
```

### Operations that do NOT require connectivity

#### Using downloaded LLMs

Once you have an LLM onto your machine, the model will run locally and you should be good to go entirely offline. Nothing you enter into LM Studio when chatting with LLMs leaves your device.

#### Chatting with documents (RAG)

When you drag and drop a document into LM Studio to chat with it or perform RAG, that document stays on your machine. All document processing is done locally, and nothing you upload into LM Studio leaves the application.

#### Running a local server

LM Studio can be used as a server to provide LLM inferencing on localhost or the local network. Requests to LM Studio use OpenAI endpoints and return OpenAI-like response objects, but stay local.

### Operations that require connectivity

Several operations, described below, rely on internet connectivity. Once you get an LLM onto your machine, you should be good to go entirely offline.

#### Searching for models

When you search for models in the Discover tab, LM Studio makes network requests (e.g. to huggingface.co). Search will not work without internet connection.

#### Downloading new models

In order to download models you need a stable (and decently fast) internet connection. You can also 'sideload' models (use models that were procured outside the app). See instructions for [sideloading models](/docs/advanced/sideload).

#### Discover tab's model catalog

Any given version of LM Studio ships with an initial model catalog built-in. The entries in the catalog are typically the state of the online catalog near the moment we cut the release. However, in order to show stats and download options for each model, we need to make network requests (e.g. to huggingface.co).

#### Downloading runtimes

[LM Runtimes](advanced/lm-runtimes) are individually packaged software libraries, or LLM engines, that allow running certain formats of models (e.g. `llama.cpp`). As of LM Studio 0.3.0 (read the [announcement](https://lmstudio.ai/blog/lmstudio-v0.3.0)) it's easy to download and even hot-swap runtimes without a full LM Studio update. To check for available runtimes, and to download them, we need to make network requests.

#### Checking for app updates

On macOS and Windows, LM Studio has a built-in app updater that's capable. The linux in-app updater [is in the works](https://github.com/lmstudio-ai/lmstudio-bug-tracker/issues/89). When you open LM Studio, the app updater will make a network request to check if there are any new updates available. If there's a new version, the app will show you a notification to update now or later.
Without internet connectivity you will not be able to update the app via the in-app updater.
