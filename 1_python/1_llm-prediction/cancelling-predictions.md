---
title: Cancelling Predictions
description: Stop an ongoing prediction in `lmstudio-python`
index: 4
---

One benefit of using the streaming API is the ability to cancel the
prediction request based on criteria that can't be represented using
the `stopStrings` or `maxPredictedTokens` configuration settings.

The following snippet illustrates cancelling the request in response
to an application specification cancellation condition (such as polling
an event set by another thread).

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms
        model = lms.llm()

        prediction_stream = model.respond_stream("What is the meaning of life?")
        cancelled = False
        for fragment in prediction_stream:
            if ...: # Cancellation condition will be app specific
                cancelled = True
                prediction_stream.cancel()
                # Note: it is recommended to let the iteration complete,
                # as doing so allows the partial result to be recorded.
                # Breaking the loop *is* permitted, but means the partial result
                # and final prediction stats won't be available to the client
        # The stream allows the prediction result to be retrieved after iteration
        if not cancelled:
            print(prediction_stream.result())

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms

        with lms.Client() as client:
            model = client.llm.model()

            prediction_stream = model.respond_stream("What is the meaning of life?")
            cancelled = False
            for fragment in prediction_stream:
                if ...: # Cancellation condition will be app specific
                    cancelled = True
                    prediction_stream.cancel()
                    # Note: it is recommended to let the iteration complete,
                    # as doing so allows the partial result to be recorded.
                    # Breaking the loop *is* permitted, but means the partial result
                    # and final prediction stats won't be available to the client
            # The stream allows the prediction result to be retrieved after iteration
            if not cancelled:
                print(prediction_stream.result())

    "Python (asynchronous API)":
      language: python
      code: |
        # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
        # Requires Python SDK version 1.5.0 or later
        import lmstudio as lms

        async with lms.AsyncClient() as client:
            model = await client.llm.model()

            prediction_stream = await model.respond_stream("What is the meaning of life?")
            cancelled = False
            async for fragment in prediction_stream:
                if ...: # Cancellation condition will be app specific
                    cancelled = True
                    await prediction_stream.cancel()
                    # Note: it is recommended to let the iteration complete,
                    # as doing so allows the partial result to be recorded.
                    # Breaking the loop *is* permitted, but means the partial result
                    # and final prediction stats won't be available to the client
            # The stream allows the prediction result to be retrieved after iteration
            if not cancelled:
                print(prediction_stream.result())

```
