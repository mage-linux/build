#!/bin/sh -e

version=1.32.1
source=https://busybox.net/downloads/busybox-$version.tar.bz2

wget "$source"
tar xf "busybox-$version.tar.bz2"
cd "busybox-$version"

make defconfig
echo "CONFIG_STATIC=y
CONFIG_EXTRA_CFLAGS=$CFLAGS -I$1/usr/include" >> .config

make "$MAKEFLAGS"

cp busybox "$1/usr/bin/busybox"
cd "$1"
for util in $("./usr/bin/busybox" --list-full); do
  ln -s /usr/bin/busybox "$util"
done
