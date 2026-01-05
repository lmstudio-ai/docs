---
title: System Requirements
description: Supported CPU, GPU types for LM Studio on Mac (M1/M2/M3/M4), Windows (x64/ARM), and Linux (x64/ARM64)
index: 3
---

## macOS

- Chip: Apple Silicon (M1/M2/M3/M4).
- macOS 14.0 or newer is required.
- 16GB+ RAM recommended.
  - You may still be able to use LM Studio on 8GB Macs, but stick to smaller models and modest context sizes.
- Intel-based Macs are currently not supported. Chime in [here](https://github.com/lmstudio-ai/lmstudio-bug-tracker/issues/9) if you are interested in this.

## Windows

LM Studio is supported on both x64 and ARM (Snapdragon X Elite) based systems.

- CPU: AVX2 instruction set support is required (for x64)
- RAM: LLMs can consume a lot of RAM. At least 16GB of RAM is recommended.
- GPU: at least 4GB of dedicated VRAM is recommended.

## Linux

LM Studio is supported on both x64 and ARM64 (aarch64) based systems.

- LM Studio for Linux is distributed as an AppImage.
- Ubuntu 20.04 or newer is required
- Ubuntu versions newer than 22 are not well tested. Let us know if you're running into issues by opening a bug [here](https://github.com/lmstudio-ai/lmstudio-bug-tracker).
- CPU:
  - On x64, LM Studio ships with AVX2 support by default
