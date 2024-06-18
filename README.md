# Overview

Docker Compose for Arbitrum Nitro

Copy `default.env` to `.env`, adjust values for the right network.

Meant to be used with https://github.com/CryptoManufaktur-io/central-proxy-docker for traefik and Prometheus remote write;
use `ext-network.yml` in that case

If you want the RPC ports exposed locally, use `rpc-shared.yml` in `COMPOSE_FILE` inside `.env`

The `./arbd` script can be used as a quick-start:

`./arbd install`

`cp default.env .env`

Adjust variables as needed, particularly `L2_CHAIN_ID` and `L1_RPC`

`./arbd up`

To update the software, run `./arbd update` and then `./arbd up`

This is Arbitrum Docker v4.0.0
