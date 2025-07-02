---
title: "Generator"
description: "Writing generators for LM Studio plugins using TypeScript"
index: 4
---

```lms_private_beta
Plugin support is currently in private beta. [Join the beta here](https://forms.gle/ZPfGLMvVC6DbSRQm9).
```

Generators are replacement for local LLMs. They act like a token source. When a plugin with a generator is used, LM Studio will no longer use the local model to generate text. The generator will be used instead.

Generators are useful for implementing adapters for external models, such as using a remote LM Studio instance or other online models.

If a plugin contains a generator, it will no longer show up in the plugins list. Instead, it will show up in the model dropdown and act as a model. If your plugins contains [Tools Provider](./tools-providers.md) or [Prompt Preprocessor](./prompt-preprocessors.md), they will be used when your generator is being selected.

## Text-Only Generators

Generators take in the the generator controller and the current conversation state, start the generation, and then report the generated text using the `ctl.fragmentGenerated` method.

The following is an example of a simple generator that echos back the last user message with 200 ms delay between each word:

```lms_code_snippet
  title: "src/toolsProvider.ts"
  variants:
    TypeScript:
      language: typescript
      code: |
        import { Chat, GeneratorController } from "@lmstudio/sdk";

        export async function generate(ctl: GeneratorController, chat: Chat) {
          // Just echo back the last message
          const lastMessage = chat.at(-1).getText();
          // Split the last message into words
          const words = lastMessage.split(/(?= )/);
          for (const word of words) {
            ctl.fragmentGenerated(word); // Send each word as a fragment
            ctl.abortSignal.throwIfAborted(); // Allow for cancellation
            await new Promise((resolve) => setTimeout(resolve, 200)); // Simulate some processing time
          }
        }
```

## Tool Call Support for Generators

To enable tool use, it is slightly more involved. Too see a comprehensive example that adapts OpenAI API, see the [openai-compat-endpoint plugin](https://lmstudio.ai/lmstudio/openai-compat-endpoint).

You can read the definition of tools available using `ctl.getToolDefinitions()`. For example, if you are making an online model adapter, you need to pass the tool definition to the model.

Once the model starts to make tool calls, you need to tell LM Studio about those calls.

Use `ctl.toolCallGenerationStarted` to report the start of a tool call generation (i.e. the model starts to generate a tool call).

Use `ctl.toolCallGenerationEnded` to report a successful generation of a tool call or use `ctl.toolCallGenerationFailed` to report a failed generation of a tool call.

Optionally, you can also `ctl.toolCallGenerationNameReceived` to eagerly report the name of the tool being called once that is available. You can also use `ctl.toolCallGenerationArgumentFragmentGenerated` to report fragments of the tool call arguments as they are generated. These two methods are useful for providing better user experience, but are not strictly necessary.

Overall, your generator must call these ctl methods in the following order:

1. 0 - N calls to `ctk.fragmentGenerated` to report the generated non-tool-call text fragments.
2. For each tool call:
   1. Call `ctl.toolCallGenerationStarted` to indicate the start of a tool call generation.
   2. (Optionally) Call `ctl.toolCallGenerationNameReceived` to report the name of the tool being called.
   3. (Optionally) Call any times of `ctl.toolCallGenerationArgumentFragmentGenerated` to report the generated fragments of the tool call arguments.
   4. Call either `ctl.toolCallGenerationEnded` to report a successful generation of the tool call or `ctl.toolCallGenerationFailed` to report a failed generation of the tool call.
   5. If the model generates more text between/after the tool call, 0 - N calls to `ctl.fragmentGenerated` to report the generated non-tool-call text fragments. (This should not happen normally, but it is technically possible for some smaller models to do this. **Critically: this is not the same as model receiving the tool results and continuing the conversation. This is just model refusing to stop talking after made a tool request - the tool result is not available to the model yet.** When multi-round prediction happens, i.e. the model actually receives the tool call, your generator function will be called again with the updated conversation state.)

Some API formats may report the tool name together with the beginning of the tool call generation, in which case you can call `ctl.toolCallGenerationNameReceived` immediately after `ctl.toolCallGenerationStarted`.

Some API formats may not have incremental tool call updates (i.e. the entire tool call request is given at once), in which case you can just call `ctl.toolCallGenerationStarted` then immediately `ctl.toolCallGenerationEnded`.

## Custom Configurations

You can access custom configurations via `ctl.getPluginConfig` and `ctl.getGlobalPluginConfig`. See [Custom Configurations](./configurations) for more details.

## Handling Aborts

A prediction may be aborted by the user while your generator is still running. In such cases, you should handle the abort gracefully by handling the `ctl.abortSignal`.

You can learn more about `AbortSignal` in the [MDN documentation](https://developer.mozilla.org/en-US/docs/Web/API/AbortSignal).

## Examples

The following are some plugins that make use of generators:

- [lmstudio/remote-lmstudio](https://lmstudio.ai/lmstudio/remote-lmstudio)

  Basic support for using a remote LM Studio instance to generate text.

- [lmstudio/openai-compat-endpoint](https://lmstudio.ai/lmstudio/openai-compat-endpoint)

  Use any OpenAI-compatible API in LM Studio.
