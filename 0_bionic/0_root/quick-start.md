---
title: Create Your First Project
description: Create a project and run your first task in LM Studio Bionic.
index: 4
---

A project keeps related sessions and files together. Create one project for work that should share the same goal, source files, or codebase.

## Create a project

1. Create a new Project and give it a name.
2. If you want Bionic to work with a local codebase, toggle on **Allow coding**.
3. If coding is enabled, select **Choose a folder for Bionic to work in** and choose the root folder of your codebase.
4. Click **Create**.
5. In the new session, select a model if Bionic has not already chosen the **Root model**.
6. Tell the agent what you'd like to do.

## Work with documents and files

Attach or drag in files and folders to add source material. Files Bionic creates appear in the right sidebar under **Project Files**. Project Files are shared across all sessions in the same project.

For example:

> Research the options in these notes, summarize the tradeoffs, and save a recommendation as `recommendation.md`.

Learn more in [Working with Documents](/docs/bionic/agent/work-project).

## Work with a codebase

When **Allow coding** is enabled, Bionic can search the repository, edit files, use Git, and run shell commands in the selected working directory.

For example:

> Find where request timeouts are handled. Explain the current behavior, fix the failing edge case, and run the relevant tests.

Review Bionic's diffs and command output before keeping the changes.

Learn more in [Coding](/docs/bionic/agent/code-project).

## Keep tasks focused

Give Bionic a clear goal, relevant files, and a concrete output. For larger work, ask it to investigate first, then implement in the same session.

See [Projects and Sessions](/docs/bionic/projects-and-sessions) to organize more work.
