#Requires benchmark versions of simple terrain and liebherr from repo
#Takes more than an hour, if you only need specific cases, comment the others out
#Keep in mind that without any input things like collision, networking and other stuff don't happen and are not reflected in the resulting profile

#Callgrind
#1 truck
timeout -sINT 10m valgrind --tool=callgrind --num-callers=5 ~/ror-codehg/bin/RoR -map simple2 -truck liebherr.truck -enter
#3 trucks
timeout -sINT 10m valgrind --tool=callgrind --num-callers=5 ~/ror-codehg/bin/RoR -map simple2-2 -truck liebherr.truck -enter
#5 trucks
timeout -sINT 10m valgrind --tool=callgrind --num-callers=5 ~/ror-codehg/bin/RoR -map simple2-4 -truck liebherr.truck -enter


#Cachegrind
#1 truck
timeout -sINT 10m valgrind --tool=cachegrind --log-file="RoRcache1" --num-callers=5 ~/ror-codehg/bin/RoR -map simple2 -truck liebherr.truck -enter
#3 trucks
timeout -sINT 10m valgrind --tool=cachegrind --log-file="RoRcache3" --num-callers=5 ~/ror-codehg/bin/RoR -map simple2-2 -truck liebherr.truck -enter
#5 trucks
timeout -sINT 10m valgrind --tool=cachegrind --log-file="RoRcache5" --num-callers=5 ~/ror-codehg/bin/RoR -map simple2-4 -truck liebherr.truck -enter