---
title: "Tool calling generators"
+description: "Implement generators that can call tools in your LM Studio plugin"
index: 3
---

To enable tool use, it is slightly more involved. To see a comprehensive example that adapts OpenAI API, see the [openai-compat-endpoint plugin](https://lmstudio.ai/lmstudio/openai-compat-endpoint).

You can read the definition of tools available using `ctl.getToolDefinitions()`. For example, if you are making an online model adapter, you need to pass the tool definition to the model.

Once the model starts to make tool calls, you need to tell LM Studio about those calls.

Use `ctl.toolCallGenerationStarted` to report the start of a tool call generation (i.e. the model starts to generate a tool call).

Use `ctl.toolCallGenerationEnded` to report a successful generation of a tool call or use `ctl.toolCallGenerationFailed` to report a failed generation of a tool call.

Optionally, you can also `ctl.toolCallGenerationNameReceived` to eagerly report the name of the tool being called once that is available. You can also use `ctl.toolCallGenerationArgumentFragmentGenerated` to report fragments of the tool call arguments as they are generated. These two methods are useful for providing better user experience, but are not strictly necessary.

Overall, your generator must call these ctl methods in the following order:

1. 0 - N calls to `ctl.fragmentGenerated` to report the generated non-tool-call text fragments.
2. For each tool call:
   1. Call `ctl.toolCallGenerationStarted` to indicate the start of a tool call generation.
   2. (Optionally) Call `ctl.toolCallGenerationNameReceived` to report the name of the tool being called.
   3. (Optionally) Call any times of `ctl.toolCallGenerationArgumentFragmentGenerated` to report the generated fragments of the tool call arguments.
   4. Call either `ctl.toolCallGenerationEnded` to report a successful generation of the tool call or `ctl.toolCallGenerationFailed` to report a failed generation of the tool call.
   5. If the model generates more text between/after the tool call, 0 - N calls to `ctl.fragmentGenerated` to report the generated non-tool-call text fragments. (This should not happen normally, but it is technically possible for some smaller models to do this. **Critically: this is not the same as model receiving the tool results and continuing the conversation. This is just model refusing to stop talking after made a tool request - the tool result is not available to the model yet.** When multi-round prediction happens, i.e. the model actually receives the tool call, your generator function will be called again with the updated conversation state.)

Some API formats may report the tool name together with the beginning of the tool call generation, in which case you can call `ctl.toolCallGenerationNameReceived` immediately after `ctl.toolCallGenerationStarted`.

Some API formats may not have incremental tool call updates (i.e. the entire tool call request is given at once), in which case you can just call `ctl.toolCallGenerationStarted` then immediately `ctl.toolCallGenerationEnded`.
