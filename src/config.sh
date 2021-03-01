#!/bin/sh

MAKEFLAGS="-j$(nproc)"
export MAKEFLAGS

# The system targets qemu so we can't add march=native and -flto caused problems
# with musl so it was removed, I might put it back if I solve the problem.
OPTFLAGS="-O2 -pipe -fgraphite-identity -floop-nest-optimize"
CFLAGS="-fPIE -fstack-protector-strong -static $OPTFLAGS"
export CFLAGS

LDFLAGS="--static"
export LDFLAGS

CC=musl-gcc
export CC
