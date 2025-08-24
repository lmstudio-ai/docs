---
title: "`LLMPredictionConfigInput`"
---

### Fields

```lms_params
- name: "maxTokens"
  type: "number | false"
  optional: true
  description: "Number of tokens to predict at most. If set to false, the model will predict as many tokens as it wants.\n\nWhen the prediction is stopped because of this limit, the `stopReason` in the prediction stats will be set to `maxPredictedTokensReached`."

- name: "temperature"
  type: "number"
  optional: true
  description: "The temperature parameter for the prediction model. A higher value makes the predictions more random, while a lower value makes the predictions more deterministic. The value should be between 0 and 1."

- name: "stopStrings"
  type: "Array<string>"
  optional: true
  description: "An array of strings. If the model generates one of these strings, the prediction will stop.\n\nWhen the prediction is stopped because of this limit, the `stopReason` in the prediction stats will be set to `stopStringFound`."

- name: "toolCallStopStrings"
  type: "Array<string>"
  optional: true
  description: "An array of strings. If the model generates one of these strings, the prediction will stop with the `stopReason` `toolCalls`."

- name: "contextOverflowPolicy"
  type: "LLMContextOverflowPolicy"
  optional: true
  description: "The behavior for when the generated tokens length exceeds the context window size. The allowed values are:\n\n- `stopAtLimit`: Stop the prediction when the generated tokens length exceeds the context window size. If the generation is stopped because of this limit, the `stopReason` in the prediction stats will be set to `contextLengthReached`\n- `truncateMiddle`: Keep the system prompt and the first user message, truncate middle.\n- `rollingWindow`: Maintain a rolling window and truncate past messages."

- name: "structured"
  type: "ZodType<TStructuredOutputType> | LLMStructuredPredictionSetting"
  optional: true
  description: "Configures the model to output structured JSON data that follows a specific schema defined using Zod.\n\nWhen you provide a Zod schema, the model will be instructed to generate JSON that conforms to that schema rather than free-form text.\n\nThis is particularly useful for extracting specific data points from model responses or when you need the output in a format that can be directly used by your application."

- name: "topKSampling"
  type: "number"
  optional: true
  description: "Controls token sampling diversity by limiting consideration to the K most likely next tokens.\n\nFor example, if set to 40, only the 40 tokens with the highest probabilities will be considered for the next token selection. A lower value (e.g., 20) will make the output more focused and conservative, while a higher value (e.g., 100) allows for more creative and diverse outputs.\n\nTypical values range from 20 to 100."

- name: "repeatPenalty"
  type: "number | false"
  optional: true
  description: "Applies a penalty to repeated tokens to prevent the model from getting stuck in repetitive patterns.\n\nA value of 1.0 means no penalty. Values greater than 1.0 increase the penalty. For example, 1.2 would reduce the probability of previously used tokens by 20%. This is particularly useful for preventing the model from repeating phrases or getting stuck in loops.\n\nSet to false to disable the penalty completely."

- name: "minPSampling"
  type: "number | false"
  optional: true
  description: "Sets a minimum probability threshold that a token must meet to be considered for generation.\n\nFor example, if set to 0.05, any token with less than 5% probability will be excluded from consideration. This helps filter out unlikely or irrelevant tokens, potentially improving output quality.\n\nValue should be between 0 and 1. Set to false to disable this filter."

- name: "topPSampling"
  type: "number | false"
  optional: true
  description: "Implements nucleus sampling by only considering tokens whose cumulative probabilities reach a specified threshold.\n\nFor example, if set to 0.9, the model will consider only the most likely tokens that together add up to 90% of the probability mass. This helps balance between diversity and quality by dynamically adjusting the number of tokens considered based on their probability distribution.\n\nValue should be between 0 and 1. Set to false to disable nucleus sampling."

- name: "xtcProbability"
  type: "number | false"
  optional: true
  description: "Controls how often the XTC (Exclude Top Choices) sampling technique is applied during generation.\n\nXTC sampling can boost creativity and reduce clichés by occasionally filtering out common tokens. For example, if set to 0.3, there's a 30% chance that XTC sampling will be applied when generating each token.\n\nValue should be between 0 and 1. Set to false to disable XTC completely."

- name: "xtcThreshold"
  type: "number | false"
  optional: true
  description: "Defines the lower probability threshold for the XTC (Exclude Top Choices) sampling technique.\n\nWhen XTC sampling is activated (based on xtcProbability), the algorithm identifies tokens with probabilities between this threshold and 0.5, then removes all such tokens except the least probable one. This helps introduce more diverse and unexpected tokens into the generation.\n\nOnly takes effect when xtcProbability is enabled."

- name: "cpuThreads"
  type: "number"
  optional: true
  description: "Specifies the number of CPU threads to allocate for model inference.\n\nHigher values can improve performance on multi-core systems but may compete with other processes. For example, on an 8-core system, a value of 4-6 might provide good performance while leaving resources for other tasks.\n\nIf not specified, the system will use a default value based on available hardware."

- name: "draftModel"
  type: "string"
  optional: true
  description: "The draft model to use for speculative decoding. Speculative decoding is a technique that can drastically increase the generation speed (up to 3x for larger models) by paring a main model with a smaller draft model.\n\nSee here for more information: https://lmstudio.ai/docs/advanced/speculative-decoding\n\nYou do not need to load the draft model yourself. Simply specifying its model key here is enough."
```
