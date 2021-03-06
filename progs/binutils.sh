#!/bin/sh -e

version=2.36.1
source=https://ftp.gnu.org/gnu/binutils/binutils-$version.tar.xz

wget "$source"
tar xf "binutils-$version.tar.xz"
cd "binutils-$version"

mkdir build && cd build

../configure \
    --prefix=/ \
    --enable-deterministic-archives \
    --disable-gold \
    --enable-lto \
    --enable-ld=default \
    --enable-plugins \
    --disable-multilib \
    --disable-werror \
    --disable-readline \
    --disable-gprof \
    --with-mmap

make
make DESTDIR="$1/tools" install

make -C ld clean
make -C ld LIB_PATH=/usr/lib:/lib
cp ld/ld-new "$1/tools/bin"
