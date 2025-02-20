---
title: Text Completion
description: "Provide a string input for the model to complete"
---

## Overview

Requesting text completion is very similar to 
[requesting chat responses](/docs/sdk/python/chat-completion), just
substituting the `complete()` and `complete_stream()` text completion
methods for the `respond()` and `respond_stream()` chat response methods.

### Usage

To get a simple string completion from a loaded LLM, e.g. "The cat in the" -> "hat",
pass the string to be completed to the `complete` or `complete_stream` method on
the corresponding LLM handle. As for chat response, tou can request the response as
a stream of prediction fragments or all at once.

```lms_code_snippet
  variants:
    Python:
      language: python
      code: |
        import lmstudio as lm

        llm = lm.llm()

        # You can process the response content incrementally...
        prediction = llm.complete_stream("My name is")
        for content_fragment in prediction:
            print(content_fragment, end="", flush=True)
        # ...and then access the complete result at the end.
        result = prediction.result()

        # Alternatively, the SDK can internally handle both of those steps
        result = llm.complete("My name is")
        print(result)

    Python (with scoped resources):
      language: python
      code: |
        import lmstudio

        with lmstudio.Client() as client:
            llm = client.llm.model()

            # You can process the response content incrementally...
            prediction = llm.complete_stream("My name is")
            for content_fragment in prediction:
                print(content_fragment, end="", flush=True)
            # ...and then access the complete result at the end.
            result = prediction.result()

            # Alternatively, the SDK can internally handle both of those steps
            result = llm.complete("My name is")
            print(result)
```

Text completion predictions use the same content fragment and prediction result
types as are described for [chat response predictions](/docs/sdk/python/chat-completion).

## Advanced Usage

### Structured responses

Requesting [structured output for programmatic use](/docs/sdk/python/structured-response)
is covered on the linked page.

### Prediction metadata

Text completion predictions report metadata about the prediction process and the
model used to make the prediction in the same way as
[chat response predictions](/docs/sdk/python/chat-completion).

### Progress callbacks

Text completion predictions accept the same progress reporting callbacks as
[chat response predictions](/docs/sdk/python/chat-completion).


### Prediction configuration

Text completion predictions accept additional prediction configuration details
in the same way as [chat response predictions](/docs/sdk/python/chat-completion).
