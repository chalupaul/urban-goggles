#!/usr/bin/env bash

set -ex

USERNAME=${1:-rpcprodeng}

IMAGE=terraformawscli

VERSION=$(cat VERSION)
echo "version: ${VERSION}"

docker build -t "${USERNAME}"/"${IMAGE}":latest .

docker tag "${USERNAME}"/"${IMAGE}":latest "${USERNAME}"/"${IMAGE}":"${VERSION}"
