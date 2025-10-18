---
title: "Defining New Fields"
+description: "Define new configuration fields for your LM Studio plugin"
index: 4
---

We support the following field types:

- `string`: A text input field.

  ```lms_code_snippet
    variants:
      TypeScript:
        language: typescript
        code: |
          // ... other fields ...
          .field(
            "stringField", // The key of the field.
            "string", // Type of the field.
            {
              displayName: "A string field",
              subtitle: "Subtitle", // Optional subtitle for the field. (Show below the field)
              hint: "Hint", // Optional hint for the field. (Show on hover)
              isParagraph: false, // Whether to show a large text input area for this field.
              isProtected: false, // Whether the value should be obscured in the UI (e.g., for passwords).
              placeholder: "Placeholder text", // Optional placeholder text for the field.
            },
            "default value", // Default Value
          )
          // ... other fields ...
  ```

- `numeric`: A number input field with optional validation and slider UI.

  ```lms_code_snippet
    variants:
      TypeScript:
        language: typescript
        code: |
          // ... other fields ...
          .field(
            "numberField", // The key of the field.
            "numeric", // Type of the field.
            {
              displayName: "A number field",
              subtitle: "Subtitle for", // Optional subtitle for the field. (Show below the field)
              hint: "Hint for number field", // Optional hint for the field. (Show on hover)
              int: false, // Whether the field should accept only integer values.
              min: 0, // Minimum value for the field.
              max: 100, // Maximum value for the field.
              slider: {
                // If present, configurations for the slider UI
                min: 0, // Minimum value for the slider.
                max: 100, // Maximum value for the slider.
                step: 1, // Step value for the slider.
              },
            },
            42, // Default Value
          )
          // ... other fields ...
  ```

- `boolean`: A checkbox or toggle input field.

  ```lms_code_snippet
    variants:
      TypeScript:
        language: typescript
        code: |
          // ... other fields ...
          .field(
            "booleanField", // The key of the field.
            "boolean", // Type of the field.
            {
              displayName: "A boolean field",
              subtitle: "Subtitle", // Optional subtitle for the field. (Show below the field)
              hint: "Hint", // Optional hint for the field. (Show on hover)
            },
            true, // Default Value
          )
          // ... other fields ...
  ```

- `stringArray`: An array of string values with configurable constraints.

  ```lms_code_snippet
    variants:
      TypeScript:
        language: typescript
        code: |
          // ... other fields ...
          .field(
            "stringArrayField",
            "stringArray",
            {
              displayName: "A string array field",
              subtitle: "Subtitle", // Optional subtitle for the field. (Show below the field)
              hint: "Hint", // Optional hint for the field. (Show on hover)
              allowEmptyStrings: true, // Whether to allow empty strings in the array.
              maxNumItems: 5, // Maximum number of items in the array.
            },
            ["default", "values"], // Default Value
          )
          // ... other fields ...
  ```

- `select`: A dropdown selection field with predefined options.

  ```lms_code_snippet
    variants:
      TypeScript:
        language: typescript
        code: |
          // ... other fields ...
          .field(
            "selectField",
            "select",
            {
              displayName: "A select field",
              options: [
                { value: "option1", displayName: "Option 1" },
                { value: "option2", displayName: "Option 2" },
                { value: "option3", displayName: "Option 3" },
              ],
              subtitle: "Subtitle", // Optional subtitle for the field. (Show below the field)
              hint: "Hint", // Optional hint for the field. (Show on hover)
            },
            "option1", // Default Value
          )
          // ... other fields ...
  ```
