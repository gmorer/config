#!/usr/bin/env bash

rm -rf cache \
&& mkdir -p cache \
&& mkdir -p ${HOME}/bin \
&& cd cache \
&& JSON=`curl -s https://api.github.com/repos/macchrome/linchrome/releases/latest` \
&& URL=`echo ${JSON} | jq -r '.assets[].browser_download_url' | grep AppImage` \
&& NAME=`echo ${JSON} | jq -r '.assets[].name' | grep AppImage` \
&& wget -q ${URL} \
&& chmod +x ${NAME} \
&& ln -fs "${PWD}/${NAME}" "${HOME}/bin/chromium"

