#!/bin/sh

MAKEFLAGS="-j$(nproc)"
export MAKEFLAGS

# The system targets qemu so we can't add march=native and -flto caused problems
# with musl so it was removed, I might put it back if I solve the problem.
# OPTFLAGS="-O2 -pipe -fgraphite-identity -floop-nest-optimize"
# CFLAGS="-fPIE -fstack-protector-strong -static $OPTFLAGS"
CFLAGS="-O2 -pipe"
export CFLAGS

CXXFLAGS="$CFLAGS"
export CXXFLAGS

CC="x86_64-linux-musl-gcc -static --static"
CXX="x86_64-linux-musl-g++ -static --static"
LD=x86_64-linux-musl-ld
AR=x86_64-linux-musl-ar
AS=x86_64-linux-musl-as
RANLIB=x86_64-linux-musl-ranlib
STRIP=x86_64-linux-musl-strip
export CC CXX LD AR AS STRIP RANLIB
