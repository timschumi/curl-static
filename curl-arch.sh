#!/bin/bash -e

configure_args=()

if [ -z "$CURL_SOURCE" ]; then
    echo "Source has not been set! Exiting..."
    exit 1
fi

if [ ! -d "$CURL_SOURCE" ]; then
    echo "Source is not present! Exiting..."
    exit 1
fi

case "$1" in
  "x64")
    BUILD_DIR="$CURL_BUILD-64"
    OUT_DIR="$CURL_OUT-64"
    configure_args+=("--with-ssl=$OPENSSL_BUILD-64/target/usr/local" "--with-zlib=$ZLIB_BUILD-64/target/usr/local")
    ;;
  "x86")
    BUILD_DIR="$CURL_BUILD-32"
    OUT_DIR="$CURL_OUT-32"
    export CC="gcc -m32"
    export CXX="g++ -m32"
    export PKG_CONFIG_PATH="/usr/lib32/pkgconfig"
    configure_args+=("--with-ssl=$OPENSSL_BUILD-32/target/usr/local" "--with-zlib=$ZLIB_BUILD-32/target/usr/local")
    ;;
  *)
    echo "Unrecognized architecture: '$1'"
    exit 1
    ;;
esac

if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"
fi

mkdir -p $BUILD_DIR
cd "$BUILD_DIR"

$CURL_SOURCE/configure \
	--disable-shared \
	${configure_args[@]}

make -j2
#make test
make DESTDIR="$BUILD_DIR/target" install

rm -rf "$OUT_DIR"
cp -r "$BUILD_DIR/target/usr/local/lib" "$OUT_DIR"
