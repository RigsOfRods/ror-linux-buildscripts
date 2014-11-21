cd ~/
mkdir .rigsofrods

while true; do
    read -p "Which Pack do you want to download? 
[1]Content Pack (200MB)
[2]High Quality Pack (includes Content Pack) >1GB
[3]none/exit
input: " input

case $input in
        [1]* ) wget http://www.rigsofrods.com/repository/viewTag/id:981/download:1 -O content-pack-0.4.zip; unzip content-pack-0.4.zip -d ~/.rigsofrods/packs/; mv   ~/.rigsofrods/packs/streams/* -t ~/.rigsofrods/packs/; rmdir ~/.rigsofrods/packs/streams;;
        [2]* ) wget http://www.rigsofrods.com/repository/downloadCDN/pack_highquality04.zip -O hq-pack-0.4.zip; unzip hq-pack-0.4.zip -d ~/.rigsofrods/packs/; mv   ~/.rigsofrods/packs/streams/* -t ~/.rigsofrods/packs/; rmdir ~/.rigsofrods/packs/streams;;
        [3]* ) exit;;
        * ) echo "Please answer 1,2 or 3";;
    esac
done

echo "You can find more content at http://www.rigsofrods.com/repository/"
echo "You can find some content only in the forum: http://www.rigsofrods.com/forums/103-Showrooms-and-WIP"
echo "Also check out this list of additional content of high quality: http://www.rigsofrods.com/wiki/pages/High_Quality_Content_not_included_in_the_HQ_Pack"