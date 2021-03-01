#!/bin/sh -e

version=4.3
source=https://ftp.gnu.org/gnu/make/make-$version.tar.gz

wget "$source"
tar xf "make-$version.tar.gz"

cd "make-$version"

./configure --prefix="$1/tools" --without-guile

make "$MAKEFLAGS" && make install
