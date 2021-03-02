#!/bin/sh -e

version=0.1
source="https://github.com/mage-linux/init/releases/download/v$version/init-$version.tar.xz"

wget "$source"
tar xf "init-$version.tar.xz"
cd "init-$version"

make DESTDIR="$1" install "$MAKEFLAGS"
