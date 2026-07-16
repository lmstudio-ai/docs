---
title: Work with Generated Files and Checkpoints
description: Preview, open, export, and recover files created or changed by Bionic.
index: 3
---

When Bionic creates or changes a file, the session shows the result in the transcript. Work Project files also appear under **Workspace**.

## Preview a file

Select a generated-file card or a file in **Workspace** to open it in a Bionic tab.

Bionic can preview text, Markdown, PDFs, images, and SVG files. Other file types show an unsupported preview state, but you can still open them in another app.

## Open or save a file

Use the file actions to:

- **Open in Default App**.
- **Reveal in Finder** on macOS or **Reveal in File Explorer** on Windows.
- **Export** a project file to another location.
- **Save As** when the generated file is not already a project file.

Files in a Work Project's managed **Workspace** are already stored with the project. Linked external files stay in their original location, and allowed changes are written there.

## Automatic file history

Bionic records versions for many file changes made through its file tools. History belongs to the project, so it can include changes from more than one session.

There is no general checkpoint browser in the current Bionic interface. To recover a version, ask Bionic to inspect the recent history for a file and restore the version you want. Review the proposed restore before replacing the current file.

For example:

> Show the recent changes to `decision-memo.md`, then restore the version from before the last rewrite.

## What file history does not cover

File history is not a replacement for backups or Git:

- Shell commands and changes made directly by other apps may not be captured when they happen.
- **Rollback and Edit** rewinds the conversation and stops current work. It does not restore files.
- Changes made in another session can affect the same project files.

Export important deliverables and keep a separate backup when needed.

See [Add Files, Images, Folders, and Web Context](/docs/bionic/work-projects/adding-context) for more ways to manage project files.
