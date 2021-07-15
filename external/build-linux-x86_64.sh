#!/bin/bash

set -e

OUT_JSON="${HOME}/.cache/nim/main_r/main.json"

export CFLAGS='-fPIC -DNO_SYSLOG -flto=full'
export CCFLAGS='-fPIC -DNO_SYSLOG -flto=full'
export CXXFLAGS='-fPIC -DNO_SYSLOG -flto=full'
export LDFLAGS='-fPIC -DNO_SYSLOG -flto=full'
export CPPFLAGS='-fPIC -DNO_SYSLOG -flto=full'

nim compile \
	--compileOnly:off \
	--os:linux \
	--cpu:amd64 \
	--define:release \
	--opt:size \
	--passC:-flto=full \
	--passC:-fPIC \
	--passL:-flto=full \
	--passL:-fPIC \
	'./src/latinizepkg/main.nim'

strip './src/latinizepkg/main'

if ! [ -d './builds/linux-x86_64' ]; then
	mkdir --parent './builds/linux-x86_64'
fi

mv './src/latinizepkg/main' './builds/linux-x86_64/latinize-linux-x86_64'

rm --recursive "$(dirname ${OUT_JSON})"

echo "Build successful: $(realpath './builds/linux-x86_64/latinize-linux-x86_64')"
