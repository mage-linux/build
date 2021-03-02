#!/bin/sh -e

version=3.7.5
source="https://ftp.gnu.org/gnu/bison/bison-$version.tar.xz"

wget "$source"
tar xf "bison-$version.tar.xz"
cd "bison-$version"

./configure \
    --prefix=/ \
    --disable-nls \
    --build=x86_64-linux-musl \
    --host=x86_64-linux-musl

make
make DESTDIR="$1/tools"
