#!/bin/bash

set -e

OUT_JSON="${HOME}/.cache/nim/main_r/main.json"

export CFLAGS="-Wno-unused-command-line-argument -fPIC -DNO_SYSLOG -flto=full -fwhole-program-vtables -ffunction-sections -fdata-sections -L${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/x86_64-linux-linux/31 -L${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/lib64 -I${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include -I${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/local/include"
export CCFLAGS="-Wno-unused-command-line-argument -fPIC -DNO_SYSLOG -flto=full -fwhole-program-vtables -ffunction-sections -fdata-sections -L${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/x86_64-linux-linux/31 -L${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/lib64 -I${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include -I${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/local/include"
export CXXFLAGS="-Wno-unused-command-line-argument -fPIC -DNO_SYSLOG -flto=full -fwhole-program-vtables -ffunction-sections -fdata-sections -L${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/x86_64-linux-linux/31 -L${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/lib64 -I${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include -I${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/local/include"
export LDFLAGS="-Wno-unused-command-line-argument -fPIC -DNO_SYSLOG -flto=full -fwhole-program-vtables -ffunction-sections -fdata-sections -L${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/x86_64-linux-linux/31 -L${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/lib64 -I${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include -I${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/local/include"
export CPPFLAGS="-Wno-unused-command-line-argument -fPIC -DNO_SYSLOG -flto=full -fwhole-program-vtables -ffunction-sections -fdata-sections -L${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/x86_64-linux-linux/31 -L${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/lib64 -I${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include -I${linux_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/local/include"

nim compile \
	--compileOnly:off \
	--os:linux \
	--cpu:amd64 \
	--define:release \
	--opt:size \
	--passC:-flto=full \
	--passC:-fPIC \
	--passC:-fwhole-program-vtables \
	--passC:-ffunction-sections \
	--passC:-data-sections \
	--passL:-flto=full \
	--passL:-fPIC \
	--passL:-fwhole-program-vtables \
	--passL:-ffunction-sections \
	--passL:-data-sections \
	'./src/latinizepkg/main.nim'

strip './src/latinizepkg/main'

if ! [ -d './builds/linux-x86_64' ]; then
	mkdir --parent './builds/linux-x86_64'
fi

mv './src/latinizepkg/main' './builds/linux-x86_64/latinize-linux-x86_64'

rm --recursive "$(dirname ${OUT_JSON})"

echo "Build successful: $(realpath './builds/linux-x86_64/latinize-linux-x86_64')"
