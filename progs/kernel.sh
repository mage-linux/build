#!/bin/sh -e

version=5.12
source="https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$version.tar.xz"

wget "$source"
tar xf "linux-$version.tar.xz"

cd "linux-$version"

make defconfig "$MAKEFLAGS"

# TODO: replace with a call to sed
echo "CONFIG_UEVENT_HELPER=y" >> .config

# The Makefile asks something so we just enter default to avoid manual
# intervention
echo "
" | make
cp arch/x86_64/boot/bzImage "$1/boot/bzImage"

make headers
make headers_install ARCH=x86_64 INSTALL_HDR_PATH="$1/usr"
