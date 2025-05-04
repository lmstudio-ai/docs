---
title: Prompt Template
description: "Optionally set or modify the model's prompt template"
---

`Advanced`

By default, LM Studio will automatically configure the prompt template based on the model file's metadata. 

However, you can customize the prompt template for any model.

<hr>


### Overriding the Prompt Template for a Specific Model

Head over to the My Models tab and click on the gear ⚙️ icon to edit the model's default parameters.
###### Pro tip: you can jump to the My Models tab from anywhere by pressing `⌘` + `3` on Mac, or `ctrl` + `3` on Windows / Linux.

### Customize the Prompt Template

###### 💡 In most cases you don't need to change the prompt template

When a model doesn't come with a prompt template information, LM Studio will surface the `Prompt Template` config box in the **🧪 Advanced Configuration** sidebar.

<img src="/assets/docs/prompt-template.png" style="width:80%" data-caption="The Prompt Template config box in the chat sidebar">

You can make this config box always show up by right clicking the sidebar and selecting **Always Show Prompt Template**.

### Prompt template options

#### Jinja Template
You can express the prompt template in Jinja.

###### 💡 [Jinja](https://en.wikipedia.org/wiki/Jinja_(template_engine)) is a templating engine used to encode the prompt template in several popular LLM model file formats.

#### Manual

You can also express the prompt template manually by specifying message role prefixes and suffixes.

<hr>

#### Reasons you might want to edit the prompt template:
1. The model's metadata is incorrect, incomplete, or LM Studio doesn't recognize it
2. The model does not have a prompt template in its metadata (e.g. custom or older models)
3. You want to customize the prompt template for a specific use case