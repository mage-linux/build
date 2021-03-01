#!/bin/sh -e

version=5.11
source="https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$version.tar.xz"

wget "$source"
tar xf "linux-$version.tar.xz"

cd "linux-$version"

make defconfig "$MAKEFLAGS"

echo "CONFIG_UEVENT_HELPER=y" >> .config

# The Makefile asks something so we just enter default to avoid manual
# intervention
echo "
" | make "$MAKEFLAGS"
cp arch/x86_64/boot/bzImage "$1/boot/bzImage"

make headers "$MAKEFLAGS"
make headers_install ARCH=x86_64 INSTALL_HDR_PATH="$1/usr"
