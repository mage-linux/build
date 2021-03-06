#!/bin/sh -e

version=20210530
source="https://github.com/mage-linux/core/releases/download/$version/core-$version.tar.xz"

wget "$source"
tar xf "core-$version.tar.xz"
mkdir -p "$1/etc/pkg/repos"
mkdir -p "$1/usr/pkg/sources"
mkdir -p "$1/usr/pkg/build"
mkdir -p "$1/usr/pkg/root"
rm -rf "$1/etc/pkg/repos/core"
mv "core-$version" "$1/etc/pkg/repos/core"
