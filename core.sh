#!/bin/sh
set -eu
. ./config

#selects CMAKE_BUILD_TYPE, compiled objects will be located in $ROR_SOURCE_DIR/0_build/CMAKEBUILDTYPE
CMAKEBUILDTYPE=RelWithDebInfo


cd "$ROR_SOURCE_DIR"
if [ ! -e rigs-of-rods ]; then
  git clone https://github.com/RigsOfRods/rigs-of-rods.git
fi
cd rigs-of-rods
git pull

if [ ! -e "0_build/$CMAKEBUILDTYPE" ]; then
  mkdir -p 0_build/$CMAKEBUILDTYPE
fi
cd 0_build/$CMAKEBUILDTYPE

cmake ../../ \
-DCMAKE_INSTALL_PREFIX="$ROR_INSTALL_DIR" \
-DROR_BUILD_CONFIGURATOR:BOOL="TRUE" \
-DCMAKE_BUILD_TYPE=$CMAKEBUILDTYPE \
-DCMAKE_CXX_FLAGS="-pipe -march=native"

# CMAKE_CXX_FLAGS (flags for compiler) - Default are:
# -march=native  -- Optimize RoR for the CPU the build is performed on; executable will only be portable to systems with same or newer CPU architecture
# -pipe          -- Speeds up the compilation process. Requires >=4GB RAM.

# Optimization flags. Pick some if you want to play around with optimization
# -DCMAKE_CXX_FLAGS="-Ofast -march=native -pipe -flto -mfpmath=both -funroll-loops -floop-parallelize-all -ftree-parallelize-loops=4" \


make $ROR_MAKEOPTS
cp -R ../../bin .
sed -i '/^PluginFolder=/d' bin/plugins.cfg
echo "PluginFolder=$ROR_INSTALL_DIR/lib/OGRE" >>bin/plugins.cfg

# there's no make install target, so just copy the bin folder
cp -R bin "$ROR_INSTALL_DIR"

echo "$(tput setaf 2)Build succeeded!"
echo "NOTE: Do not forget to run RoRConfig once before RoR."
echo "NOTE: Binaries to start the game are in $ROR_INSTALL_DIR/bin"
echo "NOTE: Mods belong in ~/.rigsofrods/packs$(tput sgr 0)"
