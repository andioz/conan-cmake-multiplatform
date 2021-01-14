#!/bin/sh -e

cd "$(dirname "$(realpath "$0")")"

BUILD_DIR="build/linux-new"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

SOURCE_DIR="project"
BUILD_PROFILE="profiles/linux_build_profile"

set -x
cmake -S "$SOURCE_DIR" -B "$BUILD_DIR" -D "CONAN_BUILD_PROFILE=\${CMAKE_SOURCE_DIR}/../$BUILD_PROFILE"
cmake --build "$BUILD_DIR"
file "$BUILD_DIR/bin/hello-world-2"