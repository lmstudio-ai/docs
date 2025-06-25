---
title: Importing and Sharing
description: You can import preset files directly from disk, or pull presets made by others via URL.
index: 2
---

You can import preset by file or URL. This is useful for sharing presets with others, or for importing presets from other users.

<hr>

# Import Presets

First, click the presets dropdown in the sidebar. You will see a list of your presets along with 2 buttons: `+ New Preset` and `Import`.

Click the `Import` button to import a preset.

<img src="/assets/docs/preset-import-button.png" data-caption="Import Presets" />

## Import Presets from File

Once you click the Import button, you can select the source of the preset you want to import. You can either import from a file or from a URL.
<img src="/assets/docs/import-preset-from-file.png" data-caption="Import one or more Presets from file" />

## Import Presets from URL

Presets that are [published](/docs/app/presets/publish) to the LM Studio Hub can be imported by providing their URL.

Importing public presets does not require logging in within LM Studio.

<img src="/assets/docs/import-preset-from-url.png" data-caption="Import Presets by URL" />

### Using `lms` CLI
You can also use the CLI to import presets from URL. This is useful for sharing presets with others.

```
lms get {author}/{preset-name}
```

Example:
```bash
lms get neil/qwen3-thinking
```


### Find your config-presets directory

LM Studio manages config presets on disk. Presets are local and private by default. You or others can choose to share them by sharing the file.

Click on the `•••` button in the Preset dropdown and select "Reveal in Finder" (or "Show in Explorer" on Windows).
<img src="/assets/docs/preset-reveal-in-finder.png" data-caption="Reveal Preset in your local file system" />

This will download the preset file and automatically surface it in the preset dropdown in the app. 

### Where Hub shared presets are stored
Presets you share, and ones you download from the LM Studio Hub are saved in `~/.lmstudio/hub` on macOS and Linux, or `%USERPROFILE%\.lmstudio\hub` on Windows. 