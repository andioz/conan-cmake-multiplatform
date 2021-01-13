#!/bin/sh -e

cd "$(dirname "$(realpath "$0")")"

BUILD_DIR="build/android-old-virtualenv"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

SOURCE_DIR="project"
PROFILE="profiles/android_profile"

set -x
conan install "$SOURCE_DIR" -if "$BUILD_DIR" -b missing -pr "$PROFILE" -g virtualenv -g CMakeToolchain
set +x
. "$BUILD_DIR/activate.sh"
set -x

cmake -S "$SOURCE_DIR" -B "$BUILD_DIR"
cmake --build "$BUILD_DIR"
file "$BUILD_DIR/bin/hello-world"
