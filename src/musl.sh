#!/bin/sh

version=1.2.2
source=https://musl.libc.org/releases/musl-$version.tar.gz

wget "$source"
tar xf "musl-$version.tar.gz"

cd "musl-$version"

./configure --prefix=/

make && make DESTDIR "$fs/tools" install
