#!/bin/bash
docker build -t abernix/meteord:base ../base
docker build -t abernix/meteord:onbuild ../onbuild
docker build -t abernix/meteord:devbuild ../devbuild
docker build -t abernix/meteord:binbuild ../binbuild