[← Home](/README.md)

# LM Studio Documentation

Content from this repo is served at [lmstudio.ai/docs](https://lmstudio.ai/docs).

## Parsing rules

- Folders under docs/ are treated as sections
- Files under a section folder are treated as articles
- You can nest folders to create sub-sections
- `0_root` is a special folder that contains the root-level articles
- `index.md` is a special file that is treated as the section's landing page (served on `/docs/<section>/`)
- you can control the ordering of sections by naming them with a number prefix (e.g. `1_api`, `2_guides`, etc.)
- you can control the ordering of articles by setting the `index` field in the frontmatter
  - `index: -1` means "place this article at the end of the list"
- files and folders starting with `_` are ignored

## How to add new documentation articles

1. Create a new markdown file in the appropriate folder

2. Populate the file with the following frontmatter:

```yaml
---
title: Keyboard Shortcuts
description: Learn about the keyboard shortcuts in LM Studio
index: 2
---
```

##### Optionally set `sidebar_title:` to override the title in the sidebar

## Custom markdown component

### -> See examples in `_template_dont_edit.md`

### Multi-Language Code Snippets

See it in action on a model page: https://lmstudio.ai/model/deepseek-r1-qwen-7b

Configurations that look good:

1. title + 1 variant
2. no title + 2+ variants

````
```lms_code_snippet
  variants:
    TypeScript:
      language: typescript
      code: |
        // Multi-line TypeScript code
        function hello() {
          console.log("hey")
          return "world"
        }

    Python:
      language: python
      code: |
        # Multi-line Python code
        def hello():
            print("hey")
            return "world"
```
````

````
```lms_code_snippet
  title: "generator.py"
  variants:
    Python:
      language: python
      code: |
        # Multi-line Python code
        def hello():
            print("hey")
            return "world"
```
````

### Horizontal Stack (HStack)

Useful for placing a text block next to a code block (for example for a code explanation, or step-by-step guide)

````
```lms_hstack

# Column 1

~~~js
console.log("Hello from the code block");
~~~

:::split:::

# Column 2
Second column markdown content here

```
````

### Params

List of formatted parameters

````
### Flags 
```lms_params
- name: "[path]"
  type: "string"
  optional: true
  description: "The path of the model to load. If not provided, you will be prompted to select one"
- name: "--ttl"
  type: "number"
  optional: true
  description: "If provided, when the model is not used for this number of seconds, it will be unloaded"
- name: "--gpu"
  type: "string"
  optional: true
  description: "How much to offload to the GPU. Values: 0-1, off, max"
- name: "--context-length"
  type: "number"
  optional: true
  description: "The number of tokens to consider as context when generating text"
- name: "--identifier"
  type: "string"
  optional: true
  description: "The identifier to assign to the loaded model for API reference"
```
````
