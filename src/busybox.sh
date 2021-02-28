#!/bin/sh

version=1.32.1
source=https://busybox.net/downloads/busybox-$version.tar.bz2

wget "$source"
tar xf "busybox-$version.tar.bz2"
cd "busybox-$version"

cp "$root/files/busyboxconfig" .config
make CC="$CC" CFLAGS="$CFLAGS" "$MAKEFLAGS"

cp busybox "$fs/usr/bin/busybox"
for util in $(./usr/bin/busybox --list-full); do
  ln -s /usr/bin/busybox $util
done
