#!/bin/bash

ARCH="undefined"

if uname -m | grep -q 'arm' > /dev/null; then
  ARCH="arm"
elif uname -m | grep -q '64' > /dev/null; then
  ARCH="amd64"
else
  echo "ERROR: Not possible to identify the correct architecture"
  exit 1
fi

if command -v docker &> /dev/null; then
  docker build --pull --no-cache --build-arg ARCH=$ARCH/  -t eltonk/pihole-doh:latest-$ARCH -f $ARCH/Dockerfile .
else
  echo "ERROR: Docker is missing"
  exit 1
fi

