---
title: "Project Setup"
sidebar_title: "Project Setup"
description: "Set up your `lmstudio-python` app or script."
index: 2
---

`lmstudio` is a library published on PyPI that allows you to use `lmstudio-python` in your own projects.
It is open source and developed on GitHub.
You can find the source code [here](https://github.com/lmstudio-ai/lmstudio-python).

## Installing `lmstudio-python`

As it is published to PyPI, `lmstudio-python` may be installed using `pip`
or your preferred project dependency manager (`pdm` and `uv` are shown, but other
Python project management tools offer similar dependency addition commands).

```lms_code_snippet
  variants:
    pip:
      language: bash
      code: |
        pip install lmstudio
    pdm:
      language: bash
      code: |
        pdm add lmstudio
    uv:
      language: bash
      code: |
        uv add lmstudio
```

## Customizing the server API host and TCP port

All of the examples in the documentation assume that the server API is running locally
on the default port. The network location of the server API can be overridden by
passing a `"host:port"` string when creating the client instance.

```lms_code_snippet
  variants:
    "Python (convenience API)":
      language: python
      code: |
        import lmstudio as lms
        SERVER_API_HOST = "localhost:1234"

        # This must be the *first* SDK interaction (otherwise the SDK will
        # implicitly attempt to access the default server instance)
        lms.get_default_client(SERVER_API_HOST)

    "Python (scoped resource API)":
      language: python
      code: |
        import lmstudio as lms
        SERVER_API_HOST = "localhost:1234"
        # When using the scoped resource API, each client instance
        # can be configured to use a specific server instance
        with lms.Client(SERVER_API_HOST) as client:
            model = client.llm.model()

            for fragment in model.respond_stream("What is the meaning of life?"):
                print(fragment.content, end="", flush=True)
            print() # Advance to a new line at the end of the response
```
