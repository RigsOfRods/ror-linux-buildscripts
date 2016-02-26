#!/bin/sh
set -eu
. ./config

# Initialization
if [ ! -e "$ROR_SOURCE_DIR" ]; then
  mkdir -p "$ROR_SOURCE_DIR"
fi

# Paged Geometry
cd "$ROR_SOURCE_DIR"
if [ ! -e ogre-paged ]; then
  git clone https://github.com/Hiradur/ogre-paged.git
fi
cd ogre-paged
git pull
cmake -DCMAKE_INSTALL_PREFIX="$ROR_INSTALL_DIR" \
-DPAGEDGEOMETRY_BUILD_SAMPLES:BOOL=OFF \
-DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo .
make $ROR_MAKEOPTS
make install

# MySocketW
cd "$ROR_SOURCE_DIR"
if [ ! -e mysocketw ]; then
  git clone https://github.com/Hiradur/mysocketw.git
fi
cd mysocketw
git pull
sed -i '/^PREFIX *=/d' Makefile.conf
make $ROR_MAKEOPTS shared
PREFIX="$ROR_INSTALL_DIR" make install

