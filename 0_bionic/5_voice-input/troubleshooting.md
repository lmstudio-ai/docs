---
title: Troubleshoot Voice Input
description: Fix voice model loading, microphone access, shortcuts, and missing transcripts.
index: 2
---

Start in **Settings** → **Voice** and check the model, permissions, and **Voice Keyboard** trigger.

## Bionic says to select a model

Voice input needs an installed and selected voice model.

1. Select **Check latest**.
2. Download an available voice model.
3. Select the installed model.

If an installed model shows a repair action, repair it and try again.

## The voice model takes time to load

A voice model can take a moment to load before the first transcription. Wait for loading to finish and keep speaking only after recording starts.

Turn on **Auto load voice model** to reduce startup time on later uses.

## The microphone does not work

Check **Microphone permission** in Voice settings.

- If permission has not been requested, select **Request microphone permission**.
- If access is blocked, allow Bionic in your operating system's microphone privacy settings.
- Return to Bionic and select **Check microphone permission**.

Also confirm that the intended microphone is available to your operating system.

## Voice Keyboard does not type into another app

On macOS, allow Bionic under **System Settings** → **Privacy & Security** → **Accessibility**. Then return to Voice settings and check the permission again.

Before triggering Voice Keyboard, click an editable text field in the target app. The transcript is sent to the active app.

## The global shortcut does not start transcription

- Make sure **Voice Keyboard** is turned on.
- Check the value next to **Current**.
- Select **Record new** and choose another shortcut.
- Avoid a shortcut already used by the operating system or another app.

Select **Clear** to remove the current shortcut and set it again.

For the full setup, see [Set Up Voice Keyboard](/docs/bionic/voice-input).
