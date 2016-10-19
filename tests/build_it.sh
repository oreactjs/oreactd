#!/bin/bash
docker build --no-cache -t meteorhacks/meteord:base ../base
docker build --no-cache -t meteorhacks/meteord:onbuild ../onbuild
docker build --no-cache -t meteorhacks/meteord:devbuild ../devbuild
docker build --no-cache -t meteorhacks/meteord:binbuild ../binbuild