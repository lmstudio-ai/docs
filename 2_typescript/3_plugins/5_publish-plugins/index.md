---
title: "Sharing Plugins"
description: "How to publish your LM Studio plugins so they can be used by others"
index: 7
---

To share publish your LM Studio plugin, open the plugin directory in a terminal and run:

```bash
lms push
```

This command will package your plugin and upload it to the LM Studio Hub. You can use this command to create new plugins or update existing ones.

### Changing Plugin Names

If you wish to change the name of the plugin, you can do so by editing the `manifest.json` file in the root of your plugin directory. Look for the `name` field and update it to your desired plugin name. Note the `name` must be kebab-case.

When you `lms push` the plugin, it will be treated as a new plugin if the name has changed. You can delete the old plugin from the LM Studio Hub if you no longer need it.

### Publishing Plugins to an Organization

If you are in an organization and wish to publish the plugin to the organization, you can do so by editing the `manifest.json` file in the root of your plugin directory. Look for the `owner` field and set it to the name of your organization. When you run `lms push`, the plugin will be published to the organization instead of your personal account.

### Private Plugins

If your account supports private plugins, you can publish your plugins privately by using the `--private` flag when running `lms push`:

```bash
lms push --private
```

Private artifact is in test. Get in touch if you are interested.
