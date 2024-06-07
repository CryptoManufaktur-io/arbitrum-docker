#!/usr/bin/env bash
set -e

# Set verbosity
shopt -s nocasematch
case ${LOG_LEVEL} in
  error)
    __verbosity="--log-level 1"
    ;;
  warn)
    __verbosity="--log-level 2"
    ;;
  info)
    __verbosity="--log-level 3"
    ;;
  debug)
    __verbosity="--log-level 4"
    ;;
  trace)
    __verbosity="--log-level 5"
    ;;
  *)
    echo "LOG_LEVEL ${LOG_LEVEL} not recognized"
    __verbosity=""
    ;;
esac

# Prep datadir
if [ ! -d "/var/lib/nitro/nitro/l2chaindata" ]; then
  if [ ! -n ${SNAPSHOT} ]; then
    __snap="--init.url=${SNAPSHOT}"
  else
    __snap="--persistent.db-engine pebble"
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
  exec "$@" ${__verbosity} ${__snap} ${EXTRAS}
fi
