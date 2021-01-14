#!/bin/sh -e

cd "$(dirname "$(realpath "$0")")"

BUILD_DIR="build/android-old"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

SOURCE_DIR="project"
PROFILE="profiles/android_profile"

set -x
conan install "$SOURCE_DIR" -if "$BUILD_DIR" -b missing -pr "$PROFILE"
cmake -S "$SOURCE_DIR" -B "$BUILD_DIR"
cmake --build "$BUILD_DIR"
file "$BUILD_DIR/bin/hello-world-2"