---
title: "Technical Deepdive"
sidebar_title: "Technical Deepdive"
description: "A technical deepdive into LM Link"
index: 2
---

## How does LM Link work?

LM Link was created in close technical collaboration with Tailscale and was implemented using Tailscale's tsnet library. 

Tsnet:

* Runs fully in userspace, meaning it doesn't need kernel-level access or privileges, or touch your OS's core network settings.   
* Has its own TCP stack — like its own mini-network engine — so it can make connections without messing with your routing table or change any network settings

Additionally, LM Link is an entirely separate and self-contained use of Tailscale's networking primitives. This means LM Link will not affect any existing networks you have with Tailscale.

## What touches the LM Studio Server?

In the context of LM Link, LM Studio's backend server acts only as a discovery server for initial discovery and keepalive heartbeats. When an LM Studio instance with LM Link enabled comes online, it checks in with the server. The server then updates the Tailscale ACL (Access Control List) to accurately reflect which devices can talk to each other and which devices are removed from the network.

Once LM Studio instances discover and connect to each other, they use a websocket based protocol, transported on top of connections created by Tsnet. This protocol is composed of two layers: the underlying layer is open source and documented in the reference implementation: [https://github.com/lmstudio-ai/lmstudio-js](https://github.com/lmstudio-ai/lmstudio-js)

## What goes through the Tailscale connection?

All communication between linked devices goes exclusively through the tailscale connection and never touches the LM Studio server. This includes inference (chats), model listing, hardware information, load parameters and configuration etc. 

## Where are chats stored when I use LM Link?

When you send a prompt through the encrypted link to a remote device, the prompt is processed on the remote machine and a response is returned to the client device. Chats will always be stored on the disk of the client device.

## High level overview

1. **Device Discovery**: First, LM Link uses LM Studio's server to facilitate initial device discovery  
2. **Link Setup**: Once initial device discovery is made, the Tailscale infrastructure is used to set up the VPN-style, end-to-end encrypted tunnel between devices  
3. **Device-to-device Communication**: Once the encrypted tunnel is set up, traffic goes directly between the devices over that tunnel  
4. **End-to-end encryption**: Neither Tailscale nor LM Studio has read access to any content moving through the tunnel.
