#!/bin/sh -e

cd "$(dirname "$(realpath "$0")")"

BUILD_DIR="build/linux-old"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

PROFILE="profiles/linux_profile"

set -x
conan install . -if "$BUILD_DIR" -b missing -pr "$PROFILE"
cmake -B "$BUILD_DIR"
cmake --build "$BUILD_DIR"
file "$BUILD_DIR/bin/hello-world"