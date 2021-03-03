#!/bin/sh -e

version=1.32.1
source=https://busybox.net/downloads/busybox-$version.tar.bz2

wget "$source"
tar xf "busybox-$version.tar.bz2"
cd "busybox-$version"

make defconfig
sed -n 's/# CONFIG_STATIC is not set/CONFIG_STATIC=y/' .config
# $1 might contain / since it's path so we use a different separator
sed -n "s|CONFIG_EXTRA_CFLAGS=\"\"|CONFIG_EXTRA_CFLAGS=\"$CFLAGS -I$1/usr/include\"|" .config
sed -n "s/CONFIG_CROSS_COMPILER_PREFIX=\"\"/CONFIG_CROSS_COMPILER_PREFIX=\"x86_64-linux-musl-\"/" .config

make "$MAKEFLAGS"

cp busybox "$1/usr/bin/busybox"
cd "$1"
for util in $("./usr/bin/busybox" --list-full); do
    ln -s /usr/bin/busybox "$util"
done
