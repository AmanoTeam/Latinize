#!/bin/bash

set -e

OUT_JSON="${HOME}/.cache/nim/main_r/main.json"

export PATH="${PATH}:${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin"

export CFLAGS="-Wno-unused-command-line-argument -fPIC -DNO_SYSLOG -flto=full -fwhole-program-vtables -ffunction-sections -fdata-sections -L${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/aarch64-linux-android/31 -L${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/lib64 -I${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include -I${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/local/include"
export CCFLAGS="-Wno-unused-command-line-argument -fPIC -DNO_SYSLOG -flto=full -fwhole-program-vtables -ffunction-sections -fdata-sections -L${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/aarch64-linux-android/31 -L${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/lib64 -I${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include -I${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/local/include"
export CXXFLAGS="-Wno-unused-command-line-argument -fPIC -DNO_SYSLOG -flto=full -fwhole-program-vtables -ffunction-sections -fdata-sections -L${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/aarch64-linux-android/31 -L${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/lib64 -I${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include -I${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/local/include"
export LDFLAGS="-Wno-unused-command-line-argument -fPIC -DNO_SYSLOG -flto=full -fwhole-program-vtables -ffunction-sections -fdata-sections -L${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/aarch64-linux-android/31 -L${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/lib64 -I${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include -I${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/local/include"
export CPPFLAGS="-Wno-unused-command-line-argument -fPIC -DNO_SYSLOG -flto=full -fwhole-program-vtables -ffunction-sections -fdata-sections -L${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/aarch64-linux-android/31 -L${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/lib64 -I${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include -I${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/local/include"

export CC="${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android31-clang"
export CXX="${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android31-clang++"
export AR="${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar"
export AS="${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-as"
export LD="${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/ld"
export LIPO="${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-lipo"
export RANLIB="${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ranlib"
export OBJCOPY="${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-objcopy"
export OBJDUMP="${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-objdump"
export STRIP="${ANDROID_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-strip"

nim compile \
	--compileOnly:on \
	--os:android \
	--cpu:arm64 \
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

jq -r '.compile[][1]' "${OUT_JSON}" | awk "{sub(\"clang\",\"${CC}\")} 1" > build.sh
jq -r '.linkcmd' "${OUT_JSON}" | awk "{sub(\"clang\",\"${CC}\")} 1" >> build.sh

bash './build.sh'

"${STRIP}"  --discard-all --strip-all './src/latinizepkg/main'

if ! [ -d './builds/android-arm64' ]; then
	mkdir --parent './builds/android-arm64'
fi

mv './src/latinizepkg/main' './builds/android-arm64/latinize-android-arm64'

rm --recursive "$(dirname ${OUT_JSON})"

echo "Build successful: $(realpath './builds/android-arm64/latinize-android-arm64')"
