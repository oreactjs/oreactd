#!/bin/bash
set -x

docker build --no-cache -t abernix/meteord:base-node-4.6.1 ../base
docker build --no-cache -t abernix/meteord:onbuild-node-4.6.1 ../onbuild
docker build --no-cache -t abernix/meteord:devbuild-node-4.6.1 ../devbuild
docker build --no-cache -t abernix/meteord:binbuild-node-4.6.1 ../binbuild
