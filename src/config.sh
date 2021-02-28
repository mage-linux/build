export MAKEFLAGS
MAKEFLAGS="-j$(nproc)"

export CFLAGS
OPTFLAGS="-flto -fgraphite-identity -floop-nest-optimize"
CFLAGS="-O2 -fPIE -fstack-protector-strong -static $OPTFLAGS"

export LDFLAGS
LDFLAGS="-static"

export CC
CC=musl-gcc
