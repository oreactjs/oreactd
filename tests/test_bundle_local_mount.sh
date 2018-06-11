#!/bin/bash

: ${NODE_VERSION?"NODE_VERSION has not been set."}

set -x

function clean() {
  docker rm -f localmount
  rm -rf localmount
}

cd /tmp
clean

meteor create --release 1.7.0.1 localmount
cd localmount
meteor build --architecture=os.linux.x86_64 ./
pwd
ls -la

docker run -d \
    --name localmount \
    -e ROOT_URL=http://localmount_app \
    -v /tmp/localmount:/bundle \
    -p 9090:80 \
    "abernix/meteord:node-${NODE_VERSION}-base"

sleep 50

appContent=`curl http://localhost:9090`
clean

if [[ $appContent != *"localmount_app"* ]]; then
  echo "Failed: Bundle local mount"
  exit 1
fi