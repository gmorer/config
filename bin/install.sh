#!/usr/bin/env bash

rm -rf ${HOME}/.local/bin
ln -fs  ${PWD}/binaries ${HOME}/.local/bin
chmod +x ${HOME}/.local/bin/*
