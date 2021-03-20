#!/bin/bash -e

# Ensure the machines are up
vagrant up

# Build the libraries
vagrant ssh x86 -c "/vagrant/build.sh linux-x86"
vagrant ssh x64 -c "/vagrant/build.sh linux-x64"
vagrant ssh win -c "/vagrant/build.sh windows-x86"
vagrant ssh win -c "/vagrant/build.sh windows-x64"

# Copy out all the files
rm -rf dist-linux
mkdir -p dist-linux

cp out/zlib-linux-x86/lib/libz.a         dist-linux/libz.a
cp out/openssl-linux-x86/lib/libssl.a    dist-linux/libssl.a
cp out/openssl-linux-x86/lib/libcrypto.a dist-linux/libcrypto.a
cp out/curl-linux-x86/lib/libcurl.a      dist-linux/libcurl.a

cp out/zlib-linux-x64/lib/libz.a         dist-linux/libz-x64.a
cp out/openssl-linux-x64/lib/libssl.a    dist-linux/libssl-x64.a
cp out/openssl-linux-x64/lib/libcrypto.a dist-linux/libcrypto-x64.a
cp out/curl-linux-x64/lib/libcurl.a      dist-linux/libcurl-x64.a

rm -rf dist-windows
mkdir -p dist-windows

cp out/zlib-windows-x86/lib/libz.a         dist-windows/libz.a
cp out/openssl-windows-x86/lib/libssl.a    dist-windows/libssl.a
cp out/openssl-windows-x86/lib/libcrypto.a dist-windows/libcrypto.a
cp out/curl-windows-x86/lib/libcurl.a      dist-windows/libcurl.a

cp out/zlib-windows-x64/lib/libz.a         dist-windows/libz-x64.a
cp out/openssl-windows-x64/lib/libssl.a    dist-windows/libssl-x64.a
cp out/openssl-windows-x64/lib/libcrypto.a dist-windows/libcrypto-x64.a
cp out/curl-windows-x64/lib/libcurl.a      dist-windows/libcurl-x64.a
