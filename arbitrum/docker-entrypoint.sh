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
if [ ! -d "/var/lib/nitro/nitro/" ]; then
  __snap="--init.url=${SNAPSHOT}"
else
  __snap=""
fi

# Word splitting is desired for the command line parameters
# shellcheck disable=SC2086
exec "$@" ${__verbosity} ${__snap} ${EXTRAS}
