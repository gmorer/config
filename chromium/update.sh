#!/usr/bin/env bash

JSON=`curl -s https://api.github.com/repos/macchrome/linchrome/releases/latest` \
&& NAME=`echo ${JSON} | jq -r '.assets[].name' | grep AppImage`
if [[ -f ${PWD}/cache/${NAME} ]]; then
	echo "Nothing to update"
	exit
fi
OLDS=`ls cache` \
&& $(bash install.sh) \
&& cd cache \
&& rm -rf ${OLDS}
