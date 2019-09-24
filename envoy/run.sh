#!/bin/bash

if [ ! -z "$DEBUG" ]; then
  log_level="--log-level debug"
fi

exec envoy -c /config.json "$log_level" --v2-config-only "${@}"
