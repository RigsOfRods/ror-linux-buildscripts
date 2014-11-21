cd ~/ror-codehg
hg pull
hg update
 
rm -f CMakeCache.txt
rm -rf CmakeFiles/
cmake -DROR_USE_MYGUI="TRUE" \
-DROR_USE_OPENAL="TRUE" \
-DROR_USE_SOCKETW="TRUE" \
-DROR_USE_PAGED="TRUE" \
-DROR_USE_CAELUM="TRUE" \
-DROR_USE_ANGELSCRIPT="TRUE" \
-DCMAKE_BUILD_TYPE=RELEASE \
-DCMAKE_CXX_FLAGS="-std=c++11 -O2 -march=native -pipe" \
.

#for optimization flags see RoRcore.sh

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

echo "$(tput setaf 1)NOTE: This script does not check for errors, please scroll up and check if something went wrong.$(tput sgr 0)"