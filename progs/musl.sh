#!/bin/sh -e

version=1.2.2
source="https://musl.libc.org/releases/musl-$version.tar.gz"

wget "$source"
tar xf "musl-$version.tar.gz"

cd "musl-$version"

./configure --prefix=/ -disable-gcc-wrapper

make
make DESTDIR="$1/tools" install

mkdir -p "$1/tools/bin"
cd "$1"
ln -sf /tools/lib/libc.so tools/lib/ld-musl-x86_64.so.1
ln -sf /tools/lib/libc.so tools/bin/ldd
