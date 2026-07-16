---
title: Edit Code with Bionic
description: Use agentic code search, review inline diffs, and recover earlier file versions.
index: 2
---

Bionic can search a repository, follow references across files, and make coordinated edits. Give it the desired behavior and any constraints, not just a filename.

## Start with agentic code search

Ask Bionic to locate and explain the relevant implementation before editing:

> Find where sessions are archived and restored. List the files involved and explain the data flow. Do not change anything yet.

This lets Bionic use repository search and file tools to build context. After reviewing the explanation, continue with a focused implementation request.

## Review inline diffs

File writes appear as diffs in the session transcript. Check that the diff:

- Changes only the intended files.
- Preserves nearby behavior and project conventions.
- Includes tests or documentation when needed.
- Does not add generated files or dependencies by accident.

Also review the repository with your normal Git tools before committing.

## Rewind a conversation

Use **Rollback and Edit** on a user message to remove the messages after it, stop current work, and place the prompt back into the composer.

This rewinds the conversation only. It does **not** undo file edits or shell commands that already ran.

## Recover an earlier file version

Bionic keeps project-level history for many changes made through its file tools. Ask it to inspect a file's recent history and recover a specific version.

For example:

> Show the recent changes to `src/session.ts`. Restore the version from before the timeout refactor, but save it to a temporary file for review first.

There is no general checkpoint history screen in the current interface. Shell changes and direct writes by other apps may not be captured when they happen.

Use Git commits or another version-control system as the main rollback path for a codebase. See [Git, Shell Access, and Local Development](/docs/bionic/code-projects/git-shell-local-development).
