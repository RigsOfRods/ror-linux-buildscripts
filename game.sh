#!/bin/sh
set -eu
. ./config

# Initialization
if [ ! -e "$ROR_SOURCE_DIR" ]; then
  mkdir -p "$ROR_SOURCE_DIR"
fi

cd "$ROR_SOURCE_DIR"
if [ ! -e rigs-of-rods ]; then
  git clone --recursive  https://github.com/${YOUR_GITHUB_USERNAME}/rigs-of-rods.git --depth=5
fi
cd rigs-of-rods
git pull

if [ ! -e "0_build/$CMAKEBUILDTYPE" ]; then
  mkdir -p 0_build/$CMAKEBUILDTYPE
fi
cd 0_build/$CMAKEBUILDTYPE

cmake ../../ -GNinja \
-DCMAKE_BUILD_TYPE=$CMAKEBUILDTYPE \
-DCMAKE_CXX_FLAGS="-pipe -march=native" \
-DCMAKE_INSTALL_PREFIX="/usr/local/games/rigsofrods/"

# CMAKE_CXX_FLAGS (flags for compiler) - Default are:
# -march=native  -- Optimize RoR for the CPU the build is performed on; executable will only be portable to systems with same or newer CPU architecture
# -pipe          -- Speeds up the compilation process. Requires >=4GB RAM.

# Optimization flags. Pick some if you want to play around with optimization
# -DCMAKE_CXX_FLAGS="-Ofast -march=native -pipe -flto -mfpmath=both -funroll-loops -floop-parallelize-all -ftree-parallelize-loops=4" \

ninja
ninja zip_and_copy_resources
sudo ninja install

echo "$(tput setaf 2)Build succeeded!"
echo "NOTE: Do not forget to run RoRConfig once before RoR."
echo "NOTE: Mods belong in ~/.rigsofrods/packs"
