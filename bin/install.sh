#!/usr/bin/env bash

rm -rf ${HOME}/bin
ln -fs  ${PWD}/binaries ${HOME}/bin
chmod +x ${HOME}/bin/*
