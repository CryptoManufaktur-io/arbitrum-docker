#!/usr/bin/env bash
set -eu

# Word splitting is desired for the command line parameters
# shellcheck disable=SC2086
exec "$@" ${EXTRAS}
