---
title: System Requirements
description: Supported CPU, GPU types for LM Studio on Mac (M1/M2/M3/M4), Windows (x64/ARM), and Linux (x64)
index: 3
---

Minimum system requirements for running LM Studio.

<hr>

###### We are actively working to add support for more platforms and configurations. If you noticed an error in this page, please let us know by opening an issue on [github](https://github.com/lmstudio-ai/lmstudio-bug-tracker).

### macOS

- Chip: Apple Silicon (M1/M2/M3/M4).
- macOS 13.4 or newer is required.
  - For MLX models, macOS 14.0 or newer is required.
- 16GB+ RAM recommended.
  - You may still be able to use LM Studio on 8GB Macs, but stick to smaller models and modest context sizes.
- Intel-based Macs are currently not supported. Chime in [here](https://github.com/lmstudio-ai/lmstudio-bug-tracker/issues/9) if you are interested in this.

### Windows

LM Studio is supported on both x64 and ARM (Snapdragon X Elite) based systems.

- CPU: AVX2 instruction set support is required (for x64)
- RAM: LLMs can consume a lot of RAM. At least 16GB of RAM is recommended.

### Linux

- LM Studio for Linux is distributed as an AppImage.
- Ubuntu 20.04 or newer is required
- x64 only, aarch64 not yet supported
- Ubuntu versions newer than 22 are not well tested. Let us know if you're running into issues by opening a bug [here](https://github.com/lmstudio-ai/lmstudio-bug-tracker).
- CPU:
  - LM Studio ships with AVX2 support by default
