#!/bin/bash
docker build --no-cache -t abernix/meteord:base ../base
docker build --no-cache -t abernix/meteord:onbuild ../onbuild
docker build --no-cache -t abernix/meteord:devbuild ../devbuild
docker build --no-cache -t abernix/meteord:binbuild ../binbuild