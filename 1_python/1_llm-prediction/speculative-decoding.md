---
title: Speculative Decoding
description: API to use a draft model in speculative decoding in `lmstudio-python`
index: 5
---

_Required Python SDK version_: **1.2.0**

Speculative decoding is a technique that can substantially increase the generation speed of large language models (LLMs) without reducing response quality. See [Speculative Decoding](./../../app/advanced/speculative-decoding) for more info.

To use speculative decoding in `lmstudio-python`, simply provide a `draftModel` parameter when performing the prediction. You do not need to load the draft model separately.

```lms_code_snippet
  variants:
    "Non-streaming":
      language: python
      code: |
        import lmstudio as lms

        main_model_key = "qwen2.5-7b-instruct"
        draft_model_key = "qwen2.5-0.5b-instruct"

        model = lms.llm(main_model_key)
        result = model.respond(
            "What are the prime numbers between 0 and 100?",
            config={
                "draftModel": draft_model_key,
            }
        )

        print(result)
        stats = result.stats
        print(f"Accepted {stats.accepted_draft_tokens_count}/{stats.predicted_tokens_count} tokens")


    Streaming:
      language: python
      code: |
        import lmstudio as lms

        main_model_key = "qwen2.5-7b-instruct"
        draft_model_key = "qwen2.5-0.5b-instruct"

        model = lms.llm(main_model_key)
        prediction_stream = model.respond_stream(
            "What are the prime numbers between 0 and 100?",
            config={
                "draftModel": draft_model_key,
            }
        )
        for fragment in prediction_stream:
            print(fragment.content, end="", flush=True)
        print() # Advance to a new line at the end of the response

        stats = prediction_stream.result().stats
        print(f"Accepted {stats.accepted_draft_tokens_count}/{stats.predicted_tokens_count} tokens")
```
