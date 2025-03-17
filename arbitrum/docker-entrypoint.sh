#!/usr/bin/env bash
set -euo pipefail

# Optionally load .env file if running outside Docker Compose
if [ -f .env ]; then
  set -a
  source .env
  set +a
fi

# Use environment variables (with defaults where appropriate)
CONF_PATH="${CONF_FILE:-/data/config/nodeConfig.json}"
PARENT_URL="${PARENT_RPC:-}"
NODE_DISABLE_BLOB="${NODE_DANGEROUS_DISABLE_BLOB_READER:-true}"
VALIDATION_WASM="${VALIDATION_WASM_ENABLE:-false}"
HTTP_API="${HTTP_API:-net,web3,eth,arb,debug,txpool}"
WS_API="${WS_API:-net,web3,eth,arb,debug,txpool}"
RPC_MAX_BATCH_RESPONSE_SIZE="${RPC_MAX_BATCH_RESPONSE_SIZE:-70000000}"
RPC_BATCH_REQUEST_LIMIT="${RPC_BATCH_REQUEST_LIMIT:-0}"

# Prep datadir and determine snapshot options
if [ ! -d "/var/lib/nitro/nitro/l2chaindata" ]; then
  if [ -n "${SNAPSHOT}" ]; then
    if [[ "${SNAPSHOT}" =~ "https://" ]]; then
      __snap="--init.url=${SNAPSHOT}"
    else
      __snap="--init.latest=${SNAPSHOT}"
    fi
  else
    __snap="--init.empty --persistent.db-engine pebble --execution.caching.state-scheme path"
    touch /var/lib/nitro/state-scheme-path
  fi
else
  if [ -f "/var/lib/nitro/state-scheme-path" ]; then
    __snap="--persistent.db-engine pebble --execution.caching.state-scheme path"
  else
    __snap=""
  fi
fi

# If the prune marker exists, remove it and add the prune flag
if [ -f /var/lib/nitro/prune-marker ]; then
  rm -f /var/lib/nitro/prune-marker
  exec "$@" \
    --conf.file="${CONF_PATH}" \
    --parent-chain.connection.url="${PARENT_URL}" \
    --node.dangerous.disable-blob-reader="${NODE_DISABLE_BLOB}" \
    --validation.wasm.enable-wasmroots-check="${VALIDATION_WASM}" \
    --execution.rpc.gas-cap 99999999999999 \
    --execution.rpc.tx-fee-cap 0 \
    --execution.rpc.evm-timeout 0 \
    --http.api "${HTTP_API}" \
    --ws.api "${WS_API}" \
    --rpc.max-batch-response-size "${RPC_MAX_BATCH_RESPONSE_SIZE}" \
    --rpc.batch-request-limit "${RPC_BATCH_REQUEST_LIMIT}" \
    --init.prune full
else
  exec "$@" \
    --conf.file="${CONF_PATH}" \
    --parent-chain.connection.url="${PARENT_URL}" \
    --node.dangerous.disable-blob-reader="${NODE_DISABLE_BLOB}" \
    --validation.wasm.enable-wasmroots-check="${VALIDATION_WASM}" \
    --execution.rpc.gas-cap 99999999999999 \
    --execution.rpc.tx-fee-cap 0 \
    --execution.rpc.evm-timeout 0 \
    --http.api "${HTTP_API}" \
    --ws.api "${WS_API}" \
    --rpc.max-batch-response-size "${RPC_MAX_BATCH_RESPONSE_SIZE}" \
    --rpc.batch-request-limit "${RPC_BATCH_REQUEST_LIMIT}" \
    ${__snap} ${EXTRAS}
fi
