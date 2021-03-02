#!/bin/sh

version=1.2.2
source="https://musl.libc.org/releases/musl-$version.tar.gz"

wget "$source"
tar xf "musl-$version.tar.gz"

cd "musl-$version"

./configure --prefix=/ -disable-gcc-wrapper

make "$MAKEFLAGS"
make DESTDIR="$1/tools" install
ln -s  /usr/lib/ld-musl-x86_64.so.1 "$1/tools/usr/bin/ldd"
