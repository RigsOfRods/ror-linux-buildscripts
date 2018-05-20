#!/bin/sh
set -eu
. ./config

# Initialization
if [ ! -e "$ROR_SOURCE_DIR" ]; then
  mkdir -p "$ROR_SOURCE_DIR"
fi

cd "$ROR_SOURCE_DIR"
if [ ! -e rigs-of-rods ]; then
  git clone https://github.com/${YOUR_GITHUB_USERNAME}/rigs-of-rods.git --depth=5
fi
cd rigs-of-rods
git pull

if [ ! -e "0_build/$CMAKEBUILDTYPE" ]; then
  mkdir -p 0_build/$CMAKEBUILDTYPE
fi
cd 0_build/$CMAKEBUILDTYPE

ROR_CMAKE_ARGS=""
if [ -e "$ROR_SOURCE_DIR/ror-dependencies" ]; then
    ROR_CMAKE_ARGS=-DCMAKE_PREFIX_PATH=$ROR_SOURCE_DIR/ror-dependencies/Dependencies_Linux/
fi

cmake ../../ \
-DCMAKE_BUILD_TYPE=$CMAKEBUILDTYPE \
-DBUILD_CUSTOM_VERSION=ON \
-DCUSTOM_VERSION="0.4.8.0-shscript" \
-DCMAKE_CXX_FLAGS="-pipe -march=native" \
$ROR_CMAKE_ARGS

# CMAKE_CXX_FLAGS (flags for compiler) - Default are:
# -march=native  -- Optimize RoR for the CPU the build is performed on; executable will only be portable to systems with same or newer CPU architecture
# -pipe          -- Speeds up the compilation process. Requires >=4GB RAM.

# Optimization flags. Pick some if you want to play around with optimization
# -DCMAKE_CXX_FLAGS="-Ofast -march=native -pipe -flto -mfpmath=both -funroll-loops -floop-parallelize-all -ftree-parallelize-loops=4" \


make $ROR_MAKEOPTS
make zip_and_copy_resources
sudo make install

echo "$(tput setaf 2)Build succeeded!"
echo "NOTE: Do not forget to run RoRConfig once before RoR."
echo "NOTE: Mods belong in ~/.rigsofrods/packs"
echo "NOTE: Run content.sh if you want to install the Content Pack$(tput sgr 0)"
