---
title: Chat with Documents
description: How to provide local documents to an LLM as additional context
index: 4
---

You can attach document files (`.docx`, `.pdf`, `.txt`) to chat sessions in LM Studio.

This will provide additional context to LLMs you chat with through the app.

<hr>

## Terminology

- **Retrieval**: Identifying relevant portion of a long source document
- **Query**: The input to the retrieval operation
- **RAG**: Retrieval-Augmented Generation\*
- **Context**: the 'working memory' of an LLM. Has a maximum size

###### \* In this context, 'Generation' means the output of the LLM.
###### Context sizes are measured in "tokens". One token is often about 3/4 of a word.

## RAG vs. Full document 'in context'

If the document is short enough (i.e., if it fits in the model's context), LM Studio will add the file contents to the conversation in full. This is particularly useful for models that support longer context sizes such as Meta's Llama 3.1 and Mistral Nemo.

If the document is very long, LM Studio will opt into using "Retrieval Augmented Generation", frequently referred to as "RAG". RAG means attempting to fish out relevant bits of a very long document (or several documents) and providing them to the model for reference. This technique sometimes works really well, but sometimes it requires some tuning and experimentation.

## Tip for successful RAG

provide as much context in your query as possible. Mention terms, ideas, and words you expect to be in the relevant source material. This will often increase the chance the system will provide useful context to the LLM. As always, experimentation is the best way to find what works best.
