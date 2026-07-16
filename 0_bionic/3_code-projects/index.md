---
title: Use Code Projects
description: Work with a local codebase using Bionic's search, editing, and shell tools.
index: 1
---

A **Code Project** connects Bionic to a local working directory. Use it for tasks that require understanding or changing a codebase.

## Open a codebase

1. Create a **Code Project**.
2. Select **Select working directory**.
3. Choose the root folder of your codebase.

If you need a different folder later, open the working directory options and select **Change working directory...**.

Bionic indexes the selected folder so it can search project files. If the folder is a Git repository, the Files panel also shows the repository and current branch.

## What to ask Bionic to do

Code Projects support tasks such as:

- Finding how a feature is implemented.
- Debugging a failing behavior.
- Refactoring code across several files.
- Implementing a feature.
- Adding or updating tests.
- Updating documentation.
- Reviewing a multi-file change.

For example:

> Find the code that validates uploaded images. Explain the current flow, add support for the new size limit, update the tests, and run only the relevant test suite.

## Use an inspect, change, test workflow

For safer results:

1. Ask Bionic to inspect the repository and explain the relevant code.
2. Confirm the intended change and constraints.
3. Let it edit the files.
4. Ask it to run focused tests or checks.
5. Review the inline diffs and your Git diff.

For a large task, ask Bionic to divide the investigation into smaller parts. It can search the repository and use sub-sessions to investigate in parallel when appropriate.

Learn more about [code editing, diffs, and rollback](/docs/bionic/code-projects/code-editing) and [Git, shell access, and local development](/docs/bionic/code-projects/git-shell-local-development).
