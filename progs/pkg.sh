#!/bin/sh -e

version=0.1.1
source="https://github.com/mage-linux/pkg/releases/download/v$version/pkg-$version.tar.xz"

wget "$source"
tar xf "pkg-$version.tar.xz"
cd "pkg-$version"

make DESTDIR="$1" install
