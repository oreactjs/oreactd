#!/bin/bash
set -e
apt-get update -y
apt-get install -y curl bzip2 build-essential autoconf libtool pkg-config nasm gcc g++ python git apt-transport-https ca-certificates
