#!/usr/bin/env bash

set -e

CONTAINER_NAME="tet_dev"

mkdir -p ${HOME}/dev
podman build . -t ${CONTAINER_NAME}
ln -fs  ${PWD}/bin/start_dev ${HOME}/.local/bin/start_dev
