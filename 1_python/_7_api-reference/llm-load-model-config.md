---
title: "`LLMLoadModelConfig`"
---

### Parameters

```lms_params
- name: gpu
  description: |
    How to distribute the work to your GPUs. See {@link GPUSetting} for more information.
  public: true
  type: GPUSetting
  optional: true

- name: contextLength
  description: |
    The size of the context length in number of tokens. This will include both the prompts and the
    responses. Once the context length is exceeded, the value set in
    {@link LLMPredictionConfigBase#contextOverflowPolicy} is used to determine the behavior.

    See {@link LLMContextOverflowPolicy} for more information.
  type: number
  optional: true

- name: ropeFrequencyBase
  description: |
    Custom base frequency for rotary positional embeddings (RoPE).

    This advanced parameter adjusts how positional information is embedded in the model's
    representations. Increasing this value may enable better performance at high context lengths by
    modifying how the model processes position-dependent information.
  type: number
  optional: true

- name: ropeFrequencyScale
  description: |
    Scaling factor for RoPE (Rotary Positional Encoding) frequency.

    This factor scales the effective context window by modifying how positional information is
    encoded. Higher values allow the model to handle longer contexts by making positional encoding
    more granular, which can be particularly useful for extending a model beyond its original
    training context length.
  type: number
  optional: true

- name: evalBatchSize
  description: |
    Number of input tokens to process together in a single batch during evaluation.

    Increasing this value typically improves processing speed and throughput by leveraging
    parallelization, but requires more memory. Finding the optimal batch size often involves
    balancing between performance gains and available hardware resources.
  type: number
  optional: true

- name: flashAttention
  description: |
    Enables Flash Attention for optimized attention computation.

    Flash Attention is an efficient implementation that reduces memory usage and speeds up
    generation by optimizing how attention mechanisms are computed. This can significantly
    improve performance on compatible hardware, especially for longer sequences.
  type: boolean
  optional: true

- name: keepModelInMemory
  description: |
    When enabled, prevents the model from being swapped out of system memory.

    This option reserves system memory for the model even when portions are offloaded to GPU,
    ensuring faster access times when the model needs to be used. Improves performance
    particularly for interactive applications, but increases overall RAM requirements.
  type: boolean
  optional: true

- name: seed
  description: |
    Random seed value for model initialization to ensure reproducible outputs.

    Setting a specific seed ensures that random operations within the model (like sampling)
    produce the same results across different runs, which is important for reproducibility
    in testing and development scenarios.
  type: number
  optional: true

- name: useFp16ForKVCache
  description: |
    When enabled, stores the key-value cache in half-precision (FP16) format.

    This option significantly reduces memory usage during inference by using 16-bit floating
    point numbers instead of 32-bit for the attention cache. While this may slightly reduce
    numerical precision, the impact on output quality is generally minimal for most applications.
  type: boolean
  optional: true

- name: tryMmap
  description: |
    Attempts to use memory-mapped (mmap) file access when loading the model.

    Memory mapping can improve initial load times by mapping model files directly from disk to
    memory, allowing the operating system to handle paging. This is particularly beneficial for
    quick startup, but may reduce performance if the model is larger than available system RAM,
    causing frequent disk access.
  type: boolean
  optional: true

- name: numExperts
  description: |
    Specifies the number of experts to use for models with Mixture of Experts (MoE) architecture.

    MoE models contain multiple "expert" networks that specialize in different aspects of the task.
    This parameter controls how many of these experts are active during inference, affecting both
    performance and quality of outputs. Only applicable for models designed with the MoE architecture.
  type: number
  optional: true

- name: llamaKCacheQuantizationType
  description: |
    Quantization type for the Llama model's key cache.

    This option determines the precision level used to store the key component of the attention
    mechanism's cache. Lower precision values (e.g., 4-bit or 8-bit quantization) significantly
    reduce memory usage during inference but may slightly impact output quality. The effect varies
    between different models, with some being more robust to quantization than others.

    Set to false to disable quantization and use full precision.
  type: LLMLlamaCacheQuantizationType | false
  optional: true

- name: llamaVCacheQuantizationType
  description: |
    Quantization type for the Llama model's value cache.

    Similar to the key cache quantization, this option controls the precision used for the value
    component of the attention mechanism's cache. Reducing precision saves memory but may affect
    generation quality. This option requires Flash Attention to be enabled to function properly.

    Different models respond differently to value cache quantization, so experimentation may be
    needed to find the optimal setting for a specific use case. Set to false to disable quantization.
  type: LLMLlamaCacheQuantizationType | false
  optional: true
```
