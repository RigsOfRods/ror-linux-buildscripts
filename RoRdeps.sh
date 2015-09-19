#!/bin/sh
set -eu
. ./config

# Initialization
if [ ! -e "$ROR_SOURCE_DIR" ]; then
  mkdir -p "$ROR_SOURCE_DIR"
fi

# OGRE
cd "$ROR_SOURCE_DIR"
if [ ! -e ogre ]; then
  hg clone https://bitbucket.org/sinbad/ogre -b v1-9
fi
cd ogre
hg pull -r v1-9 && hg update
cmake -DCMAKE_INSTALL_PREFIX="$ROR_INSTALL_DIR" \
-DFREETYPE_INCLUDE_DIR=/usr/include/freetype2/ \
-DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo \
-DOGRE_BUILD_RENDERSYSTEM_GL3PLUS=ON \
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
  git clone https://github.com/MyGUI/mygui
fi
cd mygui
git pull
cmake -DCMAKE_INSTALL_PREFIX="$ROR_INSTALL_DIR" \
-DFREETYPE_INCLUDE_DIR=/usr/include/freetype2/ \
-DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo \
-DMYGUI_BUILD_DEMOS:BOOL=OFF \
-DMYGUI_BUILD_DOCS:BOOL=OFF \
-DMYGUI_BUILD_TEST_APP:BOOL=OFF \
-DMYGUI_BUILD_TOOLS:BOOL=OFF \
-DMYGUI_BUILD_PLUGINS:BOOL=OFF .
make $ROR_MAKEOPTS
make install

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

# Caelum
cd "$ROR_SOURCE_DIR"
if [ ! -e caelum ]; then
  git clone https://github.com/RigsOfRods/caelum
fi
cd caelum
git pull
cmake -DCMAKE_INSTALL_PREFIX="$ROR_INSTALL_DIR" .
make $ROR_MAKEOPTS
make install
# important step, so the plugin can load:
ln -sf "$ROR_INSTALL_DIR/lib/libCaelum.so" "$ROR_INSTALL_DIR/lib/OGRE/"

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

# Angelscript
cd "$ROR_SOURCE_DIR"
if [ ! -e angelscript ]; then
  mkdir angelscript
fi
cd angelscript
wget -c http://www.angelcode.com/angelscript/sdk/files/angelscript_2.22.1.zip
unzip -o angelscript_*.zip
cd sdk/angelscript/projects/gnuc
sed -i '/^LOCAL *=/d' makefile
# make fails when making the symbolic link, this removes the existing versions
rm -f ../../lib/*
SHARED=1 VERSION=2.22.1 make $ROR_MAKEOPTS
rm -f ../../lib/*
SHARED=1 VERSION=2.22.1 LOCAL="$ROR_INSTALL_DIR" make -s install

#Hydrax (included in RoR's source tree)
#git clone --depth=1 https://github.com/imperative/CommunityHydrax.git
#cd CommunityHydrax
#make -s -j$cpucount PREFIX=/usr/local
#sudo make install PREFIX=/usr/local
#cd ..
