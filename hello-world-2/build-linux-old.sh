#!/bin/sh -e

cd "$(dirname "$(realpath "$0")")"

BUILD_DIR="build/linux-old"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

SOURCE_DIR="project"
PROFILE="profiles/linux_profile"

set -x
cmake -S "$SOURCE_DIR" -B "$BUILD_DIR" -D "CONAN_PROFILE=\${CMAKE_SOURCE_DIR}/../$PROFILE"
cmake --build "$BUILD_DIR"
file "$BUILD_DIR/bin/hello-world-2"