# How to add LM Studio as an LLM provider

While LM Studio has an OpenAI-compatible API, it also provides SDKs for Python and TypeScript/JavaScript, offering a richer set of features tailored specifically for local AI development.

## Why use LM Studio’s SDK over OpenAI’s SDK?

LM Studio’s SDKs are designed to be clean and developer-friendly for Python and TypeScript/JavaScript users.  

They include a number of local AI-focused features not found in OpenAI's SDK, such as:

- **Model Management**: Load, unload, and manage AI models directly from memory  
- **Model Information**: Get details like context length and model size  
- **Reliable Request Handling**: Easily abort ongoing prediction requests  
- **Advanced Configuration**: Customize model load parameters and use Presets (e.g., GPU offloading, context length)  
- **Speculative Decoding**: Use advanced inference techniques for improved performance

Using LM Studio’s SDKs also means your application can automatically connect to LM Studio without needing to manually start a server or configure ports.

## Getting Started

Adding support for LM Studio as an inference provider is easy:

- [TypeScript/JavaScript Setup →](#)
- [Python Setup →](#)
