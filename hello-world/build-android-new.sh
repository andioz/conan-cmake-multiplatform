#!/bin/sh -e

cd "$(dirname "$(realpath "$0")")"

BUILD_DIR="build/android-new"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

BUILD_PROFILE="linux_build_profile"
HOST_PROFILE="android_host_profile"

# TODO this values should come from android ndk installer?
ANDROID_ABI="arm64-v8a"
CMAKE_TOOLCHAIN_FILE="../.conan/data/android-ndk/r21d/_/_/package/4db1be536558d833e52e862fd84d64d75c2b3656/build/cmake/android.toolchain.cmake"

set -x
conan install . -if "$BUILD_DIR" -b missing -pr:b "$BUILD_PROFILE" -pr:h "$HOST_PROFILE"
cmake -B "$BUILD_DIR" -D "ANDROID_ABI=$ANDROID_ABI" -D "CMAKE_TOOLCHAIN_FILE=$CMAKE_TOOLCHAIN_FILE"
cmake --build "$BUILD_DIR"
file "$BUILD_DIR/bin/hello-world"