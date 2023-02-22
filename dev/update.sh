#!/usr/bin/env bash

CONTAINER_NAME="tet_dev"

podman build . -t ${CONTAINER_NAME}
