#!/bin/bash -e

if [ -z "$ZLIB_SOURCE" ]; then
    echo "ZLIB_SOURCE has not been set! Exiting..."
    exit 1
fi

if [ ! -d "$ZLIB_SOURCE" ]; then
    echo "ZLIB_SOURCE is not present! Exiting..."
    exit 1
fi

if [ -z "$ZLIB_BUILD" ]; then
    echo "ZLIB_BUILD has not been set! Exiting..."
    exit 1
fi

if [ -z "$ZLIB_OUT" ]; then
    echo "ZLIB_OUT has not been set! Exiting..."
    exit 1
fi

BUILD_DIR="$ZLIB_BUILD-$1"
OUT_DIR="$ZLIB_OUT-$1"

# Setup compiler
[[ "$1" = "linux-"* ]] && export CC="gcc"
[[ "$1" = "linux-"* ]] && export CXX="g++"

[[ "$1" = *"-x86" ]] && export CC="${CC} -m32"
[[ "$1" = *"-x86" ]] && export CXX="${CXX} -m32"

[[ "$1" = "linux-"* ]] && [[ "$1" = *"-x64" ]] && export CFLAGS="-fPIC"

if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"
fi

mkdir -p $BUILD_DIR
cd "$BUILD_DIR"

$ZLIB_SOURCE/configure

make -j2
make DESTDIR="$BUILD_DIR/target" install

rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR"
cp -r "$BUILD_DIR/target/usr/local/lib" "$OUT_DIR"
