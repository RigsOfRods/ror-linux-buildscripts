cd ~/
hg clone http://hg.code.sf.net/u/hiradur/rigsofrods ~/ror-codehg #unofficial repo, contains fixes for Linux
cd ~/ror-codehg

cmake -DROR_USE_MYGUI="TRUE" \
-DROR_USE_OPENAL="TRUE" \
-DROR_USE_SOCKETW="TRUE" \
-DROR_USE_PAGED="TRUE" \
-DROR_USE_CAELUM="TRUE" \
-DROR_USE_ANGELSCRIPT="TRUE" \
-DCMAKE_BUILD_TYPE=RELEASE \
-DCMAKE_CXX_FLAGS="-std=c++11 -O2 -pipe -march=native" \
.

#CMake->GCC flags:
#standard flags: -DCMAKE_CXX_FLAGS="-std=c++11 -O2 -march=native -pipe"
#if you have less than 4GB RAM remove -pipe! Otherwise GCC might crash.
#-march=native will make your binary compatible with your own CPU architecture only. If you want to share binaries with computers with different CPU architectures, remove it.

#optimization flags, pick some if you want to try them (flto increases linking time significantly, not worth the tradeoff)
#-DCMAKE_CXX_FLAGS="-std=c++11 -O2 -march=native -pipe -flto -mfpmath=both -funroll-loops -ffast-math -floop-parallelize-all -ftree-parallelize-loops=4" \

#flag for debugging: -DCMAKE_BUILD_TYPE=DEBUG (useful for profiling)


#tell ld to use libboost_system library
cd source/configurator/
for link in `find . -name 'link.txt'` 
	do
		eval "sed '1 s/$/ -lboost_system/' -i $link"
	done
cd ../main/
for link in `find . -name 'link.txt'` 
	do
		eval "sed '1 s/$/ -lboost_system/' -i $link"
	done
cd ../../

make -j$(grep -c processor /proc/cpuinfo)

echo "$(tput setaf 1)NOTE: This script does not check for errors, please scroll up and check if something went wrong."
echo "NOTE: Do not forget to run RoRConfig once before RoR."
echo "NOTE: Binaries are in ~/ror-codehg/bin$(tput sgr 0)"


