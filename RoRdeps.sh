#!/bin/sh
set -eu
. ./config

# Note: The script only downloads the latest revision of git repos without history to reduce download size.
# If you need the commit history (e.g. you are a developer) remove --depth=1 after git clone

#Initialization
if [ ! -e "$ROR_SOURCE_DIR" ]; then
  mkdir -p "$ROR_SOURCE_DIR"
fi

# OGRE
cd "$ROR_SOURCE_DIR"
if [ ! -e ogre ]; then
  hg clone https://bitbucket.org/sinbad/ogre -b v2-0
fi
cd ogre
hg pull
cmake \
-DCMAKE_INSTALL_PREFIX="$ROR_INSTALL_DIR" \
-DFREETYPE_INCLUDE_DIR=/usr/include/freetype2/ \
-DCMAKE_BUILD_TYPE=RelWithDebInfo \
-DOGRE_BUILD_SAMPLES:BOOL=OFF .
make $ROR_MAKEOPTS
make install

# OpenAL
cd "$ROR_SOURCE_DIR"
wget -c http://kcat.strangesoft.net/openal-releases/openal-soft-1.16.0.tar.bz2
tar -xvjf openal-soft-1.16.0.tar.bz2
cd openal-soft-1.16.0
cmake -DCMAKE_INSTALL_PREFIX="$ROR_INSTALL_DIR" .
make $ROR_MAKEOPTS
make install

# MyGUI
cd "$ROR_SOURCE_DIR"
if [ ! -e mygui ]; then
  git clone https://github.com/MyGUI/mygui.git
fi
cd mygui
git checkout ogre2
git pull
cmake \
-DCMAKE_INSTALL_PREFIX="$ROR_INSTALL_DIR" \
-DFREETYPE_INCLUDE_DIR=/usr/include/freetype2/ \
-DCMAKE_BUILD_TYPE=RelWithDebInfo \
-DMYGUI_BUILD_DEMOS:BOOL=OFF \
-DMYGUI_BUILD_DOCS:BOOL=OFF \
-DMYGUI_BUILD_TEST_APP:BOOL=OFF \
-DMYGUI_BUILD_TOOLS:BOOL=OFF \
-DMYGUI_BUILD_PLUGINS:BOOL=OFF .
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
