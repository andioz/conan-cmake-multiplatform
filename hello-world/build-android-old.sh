#!/bin/sh -e

cd "$(dirname "$(realpath "$0")")"

BUILD_DIR="build/android-old"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

PROFILE="android_profile"

# TODO this values should come from android ndk installer?
ANDROID_ABI="arm64-v8a"
CMAKE_TOOLCHAIN_FILE="../.conan/data/android_ndk_installer/r20/bincrafters/stable/package/84fc5086d5b84ea42507b9623275f83e74452fe1/build/cmake/android.toolchain.cmake"

set -x
conan install . -if "$BUILD_DIR" -b missing -pr "$PROFILE"
cmake -B "$BUILD_DIR" -D "ANDROID_ABI=$ANDROID_ABI" -D "CMAKE_TOOLCHAIN_FILE=$CMAKE_TOOLCHAIN_FILE"
cmake --build "$BUILD_DIR"
file "$BUILD_DIR/bin/hello-world"