#!/bin/bash
set -x

: ${NODE_VERSION?"NODE_VERSION has not been set."}

docker build --build-arg "NODE_VERSION=${NODE_VERSION}" -t "abernix/meteord:node-${NODE_VERSION}-base" ../base && \
  docker tag "abernix/meteord:node-${NODE_VERSION}-base" abernix/meteord:base
docker build --build-arg "NODE_VERSION=${NODE_VERSION}" -t "abernix/meteord:node-${NODE_VERSION}-onbuild" ../onbuild && \
  docker tag "abernix/meteord:node-${NODE_VERSION}-onbuild" abernix/meteord:onbuild
docker build --build-arg "NODE_VERSION=${NODE_VERSION}" -t "abernix/meteord:node-${NODE_VERSION}-devbuild" ../devbuild && \
  docker tag "abernix/meteord:node-${NODE_VERSION}-devbuild" abernix/meteord:devbuild
docker build --build-arg "NODE_VERSION=${NODE_VERSION}" -t "abernix/meteord:node-${NODE_VERSION}-binbuild" ../binbuild && \
  docker tag "abernix/meteord:node-${NODE_VERSION}-binbuild" abernix/meteord:binbuild
