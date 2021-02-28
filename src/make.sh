#!/bin/sh

version=4.3
source=https://ftp.gnu.org/gnu/make/make-$version.tar.gz

wget "$source"
tar xf "make-$version.tar.gz"

cd "make-$version.tar.gz"

./configure --host=x86_64-linux-musl --prefix="$fs/tools" --without-guile

make && make install
