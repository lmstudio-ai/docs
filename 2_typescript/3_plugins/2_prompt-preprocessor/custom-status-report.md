---
title: "Custom Status Report"
+description: "Report status updates during prompt preprocessing in your prompt preprocessor"
index: 4
---

Depending on the task, the prompt preprocessor may take some time to complete, for example, it may need to fetch some data from the internet or perform some heavy computation. In such cases, you can report the status of the preprocessing using `ctl.setStatus`.

```lms_code_snippet
  title: "src/promptPreprocessor.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        const status = ctl.createStatus({
          status: "loading",
          text: "Preprocessing.",
        });
```

You can update the status at any time by calling `status.setState`.

```lms_code_snippet
  title: "src/promptPreprocessor.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        status.setState({
          status: "done",
          text: "Preprocessing done.",
        })
```

You can even add sub status to the status:

```lms_code_snippet
  title: "src/promptPreprocessor.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        const subStatus = status.addSubStatus({
          status: "loading",
          text: "I am a sub status."
        });
```
