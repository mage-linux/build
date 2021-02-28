#!/bin/sh

cd build

version=5.11
source="https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$version.tar.xz"

wget "$source"
tar xf "linux-$version"

cd "linux-$version"

make defconfig

echo "CONFIG_UEVENT_HELPER=y" >> .config

make headers "$MAKEFLAGS"
make "$MAKEFLAGS"
