# Arbitrum Classic on Akash Network

## Do you need to run a Classic node?
Arbitrum One has been upgraded to Nitro, the latest Arbitrum tech stack. "Arbitrum Classic" is term for the old, pre-Nitro tech stack. The Nitro node databases have the raw data of all blocks, including pre-Nitro blocks. However, Nitro nodes cannot execute anything on pre-Nitro blocks. You need an Arbitrum Classic archive node to execute data on pre-Nitro blocks.

## Required parameters
- --l1.url=<Layer 1 Ethereum RPC URL>
**Must provide standard Ethereum node RPC endpoint.**
- --node.chain-id=<L2 Chain ID>
**Must use 42161 for Arbitrum One**

## Important ports
- RPC: 8547
- WebSocket: 8548

## Example RPC request
```
curl http://localhost:8547 \
  -X POST \
  -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"net_version","params":[],"id":67}'
```

## Docs
Docker container from [Arbitrum Docs](https://docs.arbitrum.io/run-arbitrum-node/more-types/run-classic-node)
