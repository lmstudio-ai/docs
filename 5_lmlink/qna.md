---
title: "Q&A"
sidebar_title: "Q&A"
description: "Answers to common questions about LM Link."
index: 3
---

## Q&A

Got questions about LM Link? We cover some of the most common questions below.

#### Q: Does LM Link open up my computer to the public internet?
A: No! All your devices in the LM Link network communicate with each other using Tailscale’s internal end-to-end encrypted connections. None of your devices are ever exposed to the public Internet.

#### Q: Can I use remote models with LM Studio's local server?
A: Yes. Any model in your LM Link network can be used as if they are local. This means that any tool that already connects to your local LM Studio will be able to use remote models as well, just by pointing to localhost:1234 as usual.

#### Q: Can I use remote models through the LM Studio API/SDKs?
A: Yes. Any model in your LM Link network can be used as if they are local. Just specify the model key as usual. If the model can be found on a remote device, it can be used through LM Link.

#### Q: Will LM Link interfere with my existing Tailscale VPN?
A: No. LM Link is an entirely separate and self-contained utilization of Tailscale VPN primitives. LM Link will coexist with other Tailscale utilization on your machine or network, with no interference or interplay. 

#### Q: Can LM Studio’s server see my chats?
A: No. LM Studio’s server is only used as a discovery server that helps LM Studio/llmster instances find each other. All communication afterwards, including chats and model listing, happens within Tailscale’s end-to-end encrypted connection.

#### Q: How can I disable LM Link?
A: In the LM Studio app, go to Settings -> LM Link -> Enable LM Link - OFF. If you are using llmster (our headless daemon), run `lms link disable`.

#### Q: Why does a device show up as “disconnected”?
A: LM Link uses end-to-end encrypted tunnels to connect to each other. If a device shows up as “disconnected”, it is possible that device has crashed but has not reported to the discovery server. Please make sure LM Studio/llmster is indeed running on that device. If the error persists, please report a bug at [bugs@lmstudio.ai](mailto:bugs@lmstudio.ai).

#### Q: If I have the same model on multiple devices, how do I choose which one to use?
A: If you are loading the model via LM Studio or `lms load`, the same model on different devices will show up as separate entries, with the device name identified. If you are loading models via API/SDK, you can set a preferred device from the in-app LM Link page, or use command `lms link set-preferred-device`. Once set, the model will always load on your preferred device.

#### Q: Can linked devices access resources on my computer?
A: No. LM Link does not modify your operating system, and your devices are not exposed to each other. Only LM Studio/llmster instances can communicate with each other through LM Link.

#### Q: Can I use my existing Tailscale network?
A: Not at the moment. When you enable LM Link we create a dedicated network programmatically and take full control over the ACL. This will not work well with any existing Tailscale networks. If you wish, you can DIY several aspects of the LM Link feature set yourself.


