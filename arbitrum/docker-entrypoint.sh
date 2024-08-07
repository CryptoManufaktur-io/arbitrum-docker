#!/usr/bin/env bash
set -eu

# Prep datadir
if [ ! -d "/var/lib/nitro/nitro/l2chaindata" ]; then
  if [ -n "${SNAPSHOT}" ]; then
    __snap="--init.url=${SNAPSHOT}"
  else
    __snap="--init.empty --persistent.db-engine pebble --execution.caching.state-scheme path"
  fi
else
  __snap=""
fi

if [ -f /var/lib/nitro/prune-marker ]; then
  rm -f /var/lib/nitro/prune-marker
  exec "$@" --init.prune full
else
# Word splitting is desired for the command line parameters
# shellcheck disable=SC2086
  exec "$@" ${__snap} ${EXTRAS}
fi
