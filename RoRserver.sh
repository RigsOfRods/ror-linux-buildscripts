# Compiles the server for Rigs of Rods
# To run a public server additional setup is required, see www.rigsofrods.com/wiki/pages/Compiling_Server

set -eu
. ./config


cd "$ROR_SOURCE_DIR"
if [ ! -e ror-server ]; then
  git clone https://github.com/RigsOfRods/ror-server.git
fi
cd ror-server
git pull
cmake -DCMAKE_INSTALL_PREFIX="$ROR_INSTALL_DIR" \
-DRORSERVER_NO_STACKLOG:BOOL=ON \
-DRORSERVER_CRASHHANDLER:BOOL=ON \
-DRORSERVER_GUI:BOOL=ON \
-DRORSERVER_WITH_ANGELSCRIPT:BOOL=ON \
-DRORSERVER_WITH_WEBSERVER:BOOL=OFF \
-DCMAKE_BUILD_TYPE=RelWithDebInfo \
.

make $ROR_MAKEOPTS
make install
