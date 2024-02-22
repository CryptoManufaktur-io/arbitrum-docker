# Overview

Docker Compose for Arbitrum Nitro

Copy `default.env` to `.env`, adjust values for the right network.

Meant to be used with https://github.com/CryptoManufaktur-io/base-docker-environment for traefik and Prometheus remote write;
use `ext-network.yml` in that case

If you want the RPC ports exposed locally, use `rpc-shared.yml` in `COMPOSE_FILE` inside `.env`

The `./ethd` script can be used as a quick-start:

`./ethd install`

`cp default.env .env`

Adjust variables as needed, particularly `L2_CHAIN_ID` and `L1_RPC`

`./ethd up`

To update the software, run `./ethd update` and then `./ethd up`

This is Arbitrum Docker v3.0.0
