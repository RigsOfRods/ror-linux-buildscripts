#!/bin/sh
set -eu
. ./config

cd "$ROR_SOURCE_DIR"
if [ ! -e rigs-of-rods ]; then
  git clone https://github.com/RigsOfRods/rigs-of-rods.git
fi
cd rigs-of-rods
git pull

PKG_CONFIG_PATH="$ROR_INSTALL_DIR/lib/pkgconfig"
export PKG_CONFIG_PATH

cmake -DCMAKE_INSTALL_PREFIX="$ROR_INSTALL_DIR" \
-DROR_USE_MYGUI="TRUE" \
-DROR_USE_OPENAL="TRUE" \
-DROR_USE_SOCKETW="TRUE" \
-DROR_USE_PAGED="TRUE" \
-DROR_USE_CAELUM="TRUE" \
-DROR_USE_ANGELSCRIPT="TRUE" \
-DCMAKE_BUILD_TYPE=RELEASE \
-DCMAKE_CXX_FLAGS="-O2 -pipe -march=native" \
.

#CMake->GCC flags:
#standard flags: -DCMAKE_CXX_FLAGS="-O2 -march=native -pipe"
#if you have less than 4GB RAM remove -pipe! Otherwise GCC might crash.
#-march=native will make your binary compatible with your own CPU architecture only. If you want to share binaries with computers with different CPU architectures, remove it.

#optimization flags, pick some if you want to try them (flto increases linking time significantly, not worth the tradeoff)
#-DCMAKE_CXX_FLAGS="-O2 -march=native -pipe -flto -mfpmath=both -funroll-loops -ffast-math -floop-parallelize-all -ftree-parallelize-loops=4" \

#flag for debugging: -DCMAKE_BUILD_TYPE=DEBUG (useful for profiling)

make $ROR_MAKEOPTS
sed -i '/^PluginFolder=/d' bin/plugins.cfg
echo "PluginFolder=$ROR_INSTALL_DIR/lib/OGRE" >>bin/plugins.cfg

#there's no make install target, so just copy the bin folder
cp -R bin "$ROR_INSTALL_DIR"

echo "$(tput setaf 1)NOTE: Do not forget to run RoRConfig once before RoR."
echo "NOTE: Binaries are in $ROR_INSTALL_DIR/bin$(tput sgr 0)"


