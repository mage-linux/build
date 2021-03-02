#!/bin/sh -e

version=10.2.0
gmp_version=6.1.2
mpfr_version=4.0.2
mpc_version=1.1.0

source="https://gcc.gnu.org/pub/gcc/releases/gcc-$version/gcc-$version.tar.xz"
gmp="https://ftp.gnu.org/gnu/gmp/gmp-$gmp_version.tar.xz"
mpfr="https://ftp.gnu.org/gnu/mpfr/mpfr-$mpfr_version.tar.xz"
mpc="https://ftp.gnu.org/gnu/mpc/mpc-$mpc_version.tar.gz"

for file in $source $gmp $mpfr $mpc; do
    wget "$file"
done

tar xf "gcc-$version.tar.xz"
cd "gcc-$version"

tar xf "../gmp-$gmp_version.tar.xz"
mv "gmp-$gmp_version" gmp

tar xf "../mpfr-$mpfr_version.tar.xz"
mv "mpfr-$mpfr_version" mpfr

tar xf "../mpc-$mpc_version.tar.gz"
mv "mpc-$mpc_version" mpc

mkdir build && cd build

../configure \
    --prefix=/ \
    --mandir=/usr/share/man \
    --infodir=/usr/share/info \
    --disable-multilib \
    --disable-symvers \
    --disable-libmpx \
    --disable-libmudflap \
    --disable-libsanitizer \
    --disable-werror \
    --disable-fixed-point \
    --disable-libstdcxx-pch \
    --disable-nls \
    --enable-checking=release \
    --enable-__cxa_atexit \
    --enable-default-pie \
    --enable-default-ssp \
    --enable-shared \
    --enable-threads \
    --enable-tls \
    --enable-languages=c,c++ \
    --without-included-gettext \
    --build=x86_64-linux-musl \
    --host=x86_64-linux-musl \
    --target=x86_64-linux-musl \
    --disable-bootstrap

make "$MAKEFLAGS"
make DESTDIR="$1/tools" install "$MAKEFLAGS"
