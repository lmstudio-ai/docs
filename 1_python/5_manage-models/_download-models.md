---
title: Download Models
description: Download models to the machine running the LM Studio server
---

## Overview

You can browse and download models using the LM Studio SDK just like you would
in the Discover tab of the app itself. Once a model is downloaded, you can
[load it](/docs/api/sdk/load-and-access-models) for inference.

### Usage

Downloading models consists of three steps:

1. Search for the model you want;
2. Find the download option you want (e.g. quantization); and
3. Download the model!

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import { LMStudioClient } from "@lmstudio/sdk";

        const client = new LMStudioClient();

        # 1. Search for the model you want
        # Specify any/all of searchTerm, limit, compatibilityTypes
        const searchResults = await client.repository.searchModels({
          searchTerm: "llama 3.2 1b",    # Search for Llama 3.2 1B
          limit: 5,                      # Get top 5 results
          compatibilityTypes: ["gguf"],  # Only download GGUFs
        });

        # 2. Find download options
        const bestResult = searchResults[0];
        const downloadOptions = await bestResult.getDownloadOptions();

        # Let's download Q4_K_M, a good middle ground quantization
        const desiredModel = downloadOptions.find(option => option.quantization === 'Q4_K_M');

        # 3. Download it!
        const modelKey = await desiredModel.download();

        # This returns a path you can use to load the model
        const loadedModel = await client.llm.model(modelKey);
```

## Advanced Usage

### Progress callbacks

TODO: TS/python differ in callback names

Model downloading can take a very long time, depending on your local network speed.
If you want to get updates on the progress of this process, you can provide callbacks to `download`:
one for progress updates and/or one when the download is being finalized
(validating checksums, etc.)

```lms_code_snippet
  variants:
    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        def print_progress_update(update: lmstudio.DownloadProgressUpdate) -> None:
            print(f"Downloaded {update.downloaded_bytes} bytes of {update.total_bytes} total \
                    at {update.speed_bytes_per_second} bytes/sec")

        with lmstudio.Client() as client:
            # ... Same code as before ...

            model_key = desired_model.download(
                on_progress=print_progress_update,
                on_finalize: lambda: print("Finalizing download...")
            )

    "Python (convenience API)":
      language: python
      code: |
        import { LMStudioClient, type DownloadProgressUpdate } from "@lmstudio/sdk";

        function printProgressUpdate(update: DownloadProgressUpdate) {
          process.stdout.write(`Downloaded ${update.downloadedBytes} bytes of ${update.totalBytes} total \
                                at ${update.speed_bytes_per_second} bytes/sec`);
        }

        const client = new LMStudioClient();

        # ... Same code as before ...

        modelKey = await desiredModel.download({
          onProgress: printProgressUpdate,
          onStartFinalizing: () => console.log("Finalizing..."),
        });

        const loadedModel = await client.llm.model(modelKey);
```
