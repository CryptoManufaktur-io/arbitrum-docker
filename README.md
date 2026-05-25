# Overview

Docker Compose for Arbitrum Nitro

Copy `default.env` to `.env`, adjust values for the right network.

Meant to be used with https://github.com/CryptoManufaktur-io/central-proxy-docker for traefik and Prometheus remote write;
use `ext-network.yml` in that case

If you want the RPC ports exposed locally, use `rpc-shared.yml` in `COMPOSE_FILE` inside `.env`

## Supported chains

Pick a chain by setting `COMPOSE_FILE` in `.env`:

- `arbitrum.yml` — Arbitrum One / Nova / Sepolia (the default)
- `apechain.yml` — ApeChain Orbit
- `mind.yml` — Mind Orbit (builds Nitro locally)
- `robinhood.yml` — Robinhood Orbit (parent chain is Ethereum L1; requires `PARENT_RPC`, `PARENT_BEACON`, and `PARTNER_KEY` in `.env`)
- `edge.yml` — Edge Orbit L3 (parent chain is Arbitrum One; requires `PARENT_RPC` pointing to Arbitrum Mainnet in `.env`)

The `./arbd` script can be used as a quick-start:

`./arbd install`

`cp default.env .env`

Adjust variables as needed, particularly `L2_CHAIN_ID` and `L1_RPC`

`./arbd up`

To update the software, run `./arbd update` and then `./arbd up`

This is Arbitrum Docker v4.1.1
