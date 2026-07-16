---
title: Git, Shell Access, and Local Development
description: Use Bionic safely with local Git repositories, shell commands, tests, and development servers.
index: 3
---

Bionic works directly in the local folder selected for a Code Project. File edits and shell commands affect that folder; they do not run in an isolated copy.

## Use Git as a safety net

Before a large task:

1. Check your current branch and working tree.
2. Commit or stash unrelated work.
3. Tell Bionic which files or areas it may change.

The Files panel shows the current Git repository and branch when available. It can also show branch information for submodules.

Bionic can run Git commands through the shell when asked. It does not replace your normal Git review process. Inspect `git status` and `git diff` before committing.

## Shell access

Shell commands run locally in the selected working directory. Bionic can use them to:

- Search or inspect the project.
- Install dependencies.
- Run tests, linters, type checks, or builds.
- Start a local development server.
- Use the project's Git commands and scripts.

Some commands can run without an approval prompt. Destructive or sensitive actions may ask for confirmation. Read the command and its working directory before approving it.

A shell command can change files without going through Bionic's file history. Use Git when you need reliable rollback.

## Run a local workflow

Give Bionic the exact validation you want:

> Implement the fix, run the focused unit test, then run the project's type check. Do not update dependencies.

If a command starts a development server, open its local URL in Bionic's built-in browser or your regular browser. Stop long-running processes when you are done.

Be careful with secrets and production credentials. Shell tools can use files and environment settings available to your local development setup.

See [Edit Code with Bionic](/docs/bionic/code-projects/code-editing) for diff and recovery guidance.
