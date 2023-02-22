#!/usr/bin/env bash

set -e

CONTAINER_NAME="tet_dev"

podman build . -t ${CONTAINER_NAME}
mkdir -p ${HOME}/dev
ln -fs  ${PWD}/bin/start_dev ${HOME}/.local/bin/start_dev
