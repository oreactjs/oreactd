#!/bin/bash

: ${NODE_VERSION?"NODE_VERSION has not been set."}

set -x

function clean() {
  docker rm -f meteor-app
  rm -rf hello
}

cd /tmp
clean

meteor create --release 1.7.0.1 hello
cd hello
echo "process.on('SIGTERM', function () { console.log('SIGTERM RECEIVED'); });" >> server/main.js

meteor build --architecture=os.linux.x86_64 ./
docker run -d \
    --name meteor-app \
    -e ROOT_URL=http://yourapp_dot_com \
    -v /tmp/hello/:/bundle \
    -p 8080:80 \
    abernix/meteord:base

sleep 50

docker stop meteor-app
found=`docker logs meteor-app | grep -c "SIGTERM RECEIVED"`
clean

if [[ $found != 1 ]]; then
  echo "Failed: Meteor app"
  exit 1
fi
