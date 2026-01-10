---
title: Per-model Defaults
description: You can set default settings for each model in LM Studio
---

`Advanced`

You can set default load settings for each model in LM Studio.

When the model is loaded anywhere in the app (including through [`lms load`](/docs/cli#load-a-model-with-options)) these settings will be used.

<hr>

### Setting default parameters for a model

Head to the My Models tab and click on the gear ⚙️ icon to edit the model's default parameters.

<img src="/assets/docs/model-settings-gear.webp" style="width:80%" data-caption="Click on the gear icon to edit the default load settings for a model.">

This will open a dialog where you can set the default parameters for the model.

<video autoplay loop muted playsinline style="width:50%" data-caption="You can set the default parameters for a model in this dialog.">
  <source src="https://files.lmstudio.ai/default-params.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

Next time you load the model, these settings will be used.


```lms_protip
#### Reasons to set default load parameters (not required, totally optional)

- Set a particular GPU offload settings for a given model
- Set a particular context size for a given model
- Whether or not to utilize Flash Attention for a given model

```




## Advanced Topics

### Changing load settings before loading a model

When you load a model, you can optionally change the default load settings.

<img src="/assets/docs/load-model.png" style="width:80%" data-caption="You can change the load settings before loading a model.">

### Saving your changes as the default settings for a model

If you make changes to load settings when you load a model, you can save them as the default settings for that model.

<img src="/assets/docs/save-load-changes.png" style="width:80%" data-caption="If you make changes to load settings when you load a model, you can save them as the default settings for that model.">


<hr>

### Community
Chat with other LM Studio power users, discuss configs, models, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).
