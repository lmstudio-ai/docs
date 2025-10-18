---
title: "Using `npm` Dependencies"
description: "How to use npm packages in LM Studio plugins"
index: 6
---

## Add dependencies to your plugin with `npm`

LM Studio plugins supports `npm` packages. You can just install them using `npm install`.

When the plugin is installed, LM Studio will automatically download all the required dependencies that are declared in `package.json` and `package-lock.json`. (The user does not need to have Node.js/npm installed.)

### `postinstall` scripts

For safety reasons, we do **not** run `postinstall` scripts. Thus please make sure you are not using any npm packages that require postinstall scripts to work.

## Using Other Package Managers

Since we rely on `package-lock.json`, lock files produced by other package managers will not work. Thus we recommend only using `npm` when developing LM Studio plugins.
