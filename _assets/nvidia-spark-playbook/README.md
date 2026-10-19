# Running the scripts

These scripts use **NVIDIA Nemotron 3.5 Super VL** (`nvidia/nemotron-3.5-super-vl`). Download and load the model on your DGX Spark by following the [LM Studio playbook](https://build.nvidia.com/playbooks/lm-studio/instructions) before running them.

Replace each script's IP placeholder with your Spark's IP address. If you use LM Link, connect through your laptop's local server using `localhost` instead.

## Javascript

Pre-reqs: User has installed `npm` and `node`

```bash
cd js
npm install @lmstudio/sdk
node run.js
```

## Python

Pre-reqs: User has installed `uv`

```bash
=
uv run --script run.py
```

## Bash

Pre-reqs: User has installed `jq` and `curl`

```bash
bash run.sh
```
