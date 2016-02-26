set -eu
. ./config

./RoRdepsapt.sh
./RoRdeps.sh
./RoRcore.sh

#remove use of AS
cd "$ROR_SOURCE_DIR/rigs-of-rods/"
patch -p1 < NO_AS.patch