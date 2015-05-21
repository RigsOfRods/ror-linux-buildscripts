#!/bin/sh
set -eu
. ./config

# Note: The script only downloads the latest revision of git repos without history to reduce download size.
# If you need the commit history (e.g. you are a developer) remove --depth=1 after git clone

#Initialization
if [ ! -e "$ROR_SOURCE_DIR" ]; then
  mkdir -p "$ROR_SOURCE_DIR"
fi

#OGRE
cd "$ROR_SOURCE_DIR"
wget -c -O ogre.zip http://bitbucket.org/sinbad/ogre/get/v1-8.zip
unzip -o ogre.zip
cd sinbad-ogre-*
cmake -DCMAKE_INSTALL_PREFIX="$ROR_INSTALL_DIR" \
-DFREETYPE_INCLUDE_DIR=/usr/include/freetype2/ \
-DCMAKE_BUILD_TYPE:STRING=Release \
-DOGRE_BUILD_SAMPLES:BOOL=OFF .
make $ROR_MAKEOPTS
make install

PKG_CONFIG_PATH="$ROR_INSTALL_DIR/lib/pkgconfig"

#OpenAL
cd "$ROR_SOURCE_DIR"
if [ ! -e openal-soft ]; then
  git clone http://repo.or.cz/openal-soft.git
fi
cd openal-soft
git pull
cmake -DCMAKE_INSTALL_PREFIX="$ROR_INSTALL_DIR" .
make $ROR_MAKEOPTS
make install

#MyGUI (needs specific revision)
cd "$ROR_SOURCE_DIR"
wget -c -O mygui.zip https://github.com/MyGUI/mygui/archive/a790944c344c686805d074d7fc1d7fc13df98c37.zip
unzip -o mygui.zip
cd mygui-*
cmake -DCMAKE_INSTALL_PREFIX="$ROR_INSTALL_DIR" \
-DFREETYPE_INCLUDE_DIR=/usr/include/freetype2/ \
-DCMAKE_BUILD_TYPE:STRING=Release \
-DMYGUI_BUILD_DEMOS:BOOL=OFF \
-DMYGUI_BUILD_DOCS:BOOL=OFF \
-DMYGUI_BUILD_TEST_APP:BOOL=OFF \
-DMYGUI_BUILD_TOOLS:BOOL=OFF \
-DMYGUI_BUILD_PLUGINS:BOOL=OFF .
make $ROR_MAKEOPTS
make install

#Paged Geometry
cd "$ROR_SOURCE_DIR"
if [ ! -e ogre-paged ]; then
  git clone --depth=1 https://github.com/Hiradur/ogre-paged.git
fi
cd ogre-paged
git pull
cmake -DCMAKE_INSTALL_PREFIX="$ROR_INSTALL_DIR" \
-DCMAKE_BUILD_TYPE:STRING=Release \
-DPAGEDGEOMETRY_BUILD_SAMPLES:BOOL=OFF .
make $ROR_MAKEOPTS
make install

#Caelum (needs specific revision for OGRE-1.8)
cd "$ROR_SOURCE_DIR"
wget -c -O caelum.zip http://caelum.googlecode.com/archive/3b0f1afccf5cb75c65d812d0361cce61b0e82e52.zip
unzip -o caelum.zip
cd caelum-*
cmake -DCMAKE_INSTALL_PREFIX="$ROR_INSTALL_DIR" \
-DCaelum_BUILD_SAMPLES:BOOL=OFF .
make $ROR_MAKEOPTS
make install
# important step, so the plugin can load:
ln -sf "$ROR_INSTALL_DIR/lib/libCaelum.so" "$ROR_INSTALL_DIR/lib/OGRE/"

#MySocketW
cd "$ROR_SOURCE_DIR"
if [ ! -e mysocketw ]; then
  git clone --depth=1 https://github.com/Hiradur/mysocketw.git
fi
cd mysocketw
git pull
sed -i '/^PREFIX *=/d' Makefile.conf
make $ROR_MAKEOPTS shared
PREFIX="$ROR_INSTALL_DIR" make install

#Angelscript
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
