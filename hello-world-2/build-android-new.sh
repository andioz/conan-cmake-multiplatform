#!/bin/sh -e

cd "$(dirname "$(realpath "$0")")"

BUILD_DIR="build/android-new"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

SOURCE_DIR="project"
BUILD_PROFILE="profiles/linux_build_profile"
HOST_PROFILE="profiles/android_host_profile"

set -x
cmake -S "$SOURCE_DIR" -B "$BUILD_DIR" -D "CONAN_BUILD_PROFILE=\${CMAKE_SOURCE_DIR}/../$BUILD_PROFILE" -D "CONAN_HOST_PROFILE=\${CMAKE_SOURCE_DIR}/../$HOST_PROFILE"
cmake --build "$BUILD_DIR"
file "$BUILD_DIR/bin/hello-world-2"