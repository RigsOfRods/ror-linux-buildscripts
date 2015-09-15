#!/bin/sh
set -eu
. ./config

cd "$ROR_SOURCE_DIR"
wget -O rigs-of-rods.zip https://github.com/RigsOfRods/rigs-of-rods/archive/0.4.5.1.zip
unzip rigs-of-rods.zip
cd rigs-of-rods
git pull

cmake \
-DCMAKE_INSTALL_PREFIX="$ROR_INSTALL_DIR" \
-DROR_USE_MYGUI="TRUE" \
-DROR_USE_OPENAL="TRUE" \
-DROR_USE_SOCKETW="TRUE" \
-DROR_USE_PAGED="TRUE" \
-DROR_USE_CAELUM="TRUE" \
-DROR_USE_ANGELSCRIPT="TRUE" \
-DCMAKE_BUILD_TYPE=RELEASE \
-DCMAKE_CXX_FLAGS="-pipe -march=native" \
.

# CMAKE_CXX_FLAGS (flags for compiler) - Default are:
# -march=native  -- Optimize RoR for the CPU the build is performed on; executable will only be portable to systems with same or newer CPU architecture
# -pipe          -- Speeds up the compilation process. Requires >=4GB RAM.

# Optimization flags. Pick some if you want to play around with optimization
# -DCMAKE_CXX_FLAGS="-Ofast -march=native -pipe -flto -mfpmath=both -funroll-loops -ffast-math -floop-parallelize-all -ftree-parallelize-loops=4" \


make $ROR_MAKEOPTS
sed -i '/^PluginFolder=/d' bin/plugins.cfg
echo "PluginFolder=$ROR_INSTALL_DIR/lib/OGRE" >>bin/plugins.cfg

# there's no make install target, so just copy the bin folder
cp -R bin "$ROR_INSTALL_DIR"

echo "$(tput setaf 1)NOTE: Do not forget to run RoRConfig once before RoR."
echo "NOTE: Binaries are in $ROR_INSTALL_DIR/bin$(tput sgr 0)"
