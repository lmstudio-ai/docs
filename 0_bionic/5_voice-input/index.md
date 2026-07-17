---
title: Voice Input in Bionic
description: Use voice input with local transcription in Bionic
index: 1
---

**Voice Input** transcribes speech locally and sends the transcript into Bionic. Currently, Bionic supports Voxtral by Mistral AI, which is a performant multilingual realtime transcription model.

## Install a voice model

1. Open **Settings** → **Voice**.
2. Under the voice model section, select **Check latest** if no model is listed.
3. Download an available voice model.
4. Select the installed model when prompted.

The first transcription may wait while the model loads. Turn on **Auto load voice model** to keep the selected model loaded so voice input starts faster.

## Allow permissions

Voice Keyboard needs microphone access.

- Select **Request microphone permission** or **Allow microphone**.
- If access was previously blocked, enable Bionic under your system's microphone privacy settings, then select **Check microphone permission** or **Check again**.

On macOS, Voice Keyboard also needs Accessibility access to send the transcript into other apps. Select **Allow Accessibility** or **Request access**, then approve Bionic in **System Settings**.

## Set the global trigger

1. In **Settings** → **Voice**, turn on **Voice Keyboard**.
2. Under **Trigger**, choose a trigger type.
3. For **Shortcut**, select **Record new** and press the key combination you want.
4. Check the shortcut shown next to **Current**.

macOS also offers trigger choices such as **Double Caps** and **2x Right Shift**.

## Transcribe into an app

1. Place the text cursor in the app where you want the transcript.
2. Use the configured Voice Keyboard trigger.
3. Speak, then stop using the selected trigger behavior.
4. Review the text before sending or saving it.

The shortcut works globally, so the active app does not need to be Bionic.
