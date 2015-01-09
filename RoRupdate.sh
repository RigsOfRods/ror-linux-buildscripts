cd ~/rigs-of-rods
git pull
 
cmake -DROR_USE_MYGUI="TRUE" \
-DROR_USE_OPENAL="TRUE" \
-DROR_USE_SOCKETW="TRUE" \
-DROR_USE_PAGED="TRUE" \
-DROR_USE_CAELUM="TRUE" \
-DROR_USE_ANGELSCRIPT="TRUE" \
-DCMAKE_BUILD_TYPE=RELEASE \
-DCMAKE_CXX_FLAGS="-O2 -pipe -march=native" \
.

make -j$(grep -c processor /proc/cpuinfo)

echo "$(tput setaf 1)NOTE: This script does not check for errors, please scroll up and check if something went wrong."
echo "NOTE: Do not forget to run RoRConfig once before RoR."
echo "NOTE: Binaries are in ~/rigs-of-rods/bin$(tput sgr 0)"