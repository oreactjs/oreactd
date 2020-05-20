#!/usr/bin/env bash

set -e

if [ -d /built_app ]; then
  cd /built_app
  yarn config set unsafe-perm true
  yarn install --production=true
else
  echo "=> You don't have an oreact app to run in this image."
  exit 1
fi

# Set a delay to wait to start meteor container
if [[ $DELAY ]]; then
  echo "Delaying startup for $DELAY seconds"
  sleep $DELAY
fi

# Honour already existing PORT setup
export PORT=${PORT:-80}

echo "=> Starting oreact app on port:$PORT"
exec oreact start prod
#exec node ${OREACTD_NODE_OPTIONS} server.js
