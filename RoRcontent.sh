cd ~/
mkdir -p ~/.rigsofrods/packs

while true; do
    read -p "Which Pack do you want to download? 
[1]Content Pack (200MB)
[2]High Quality Pack (includes Content Pack) >1GB
[3]none/exit
input: " input

case $input in
        [1]* ) wget http://www.rigsofrods.com/repository/viewTag/id:981/download:1 -O content-pack-0.4.zip; unzip content-pack-0.4.zip -d ~/.rigsofrods/packs/; mv ~/.rigsofrods/packs/ContentPack04/* -t ~/.rigsofrods/packs/; rmdir ~/.rigsofrods/packs/ContentPack04;;
        [2]* ) wget http://www.rigsofrods.com/repository/viewTag/id:982/download:1 -O hq-pack-0.4.zip; unzip hq-pack-0.4.zip -d ~/.rigsofrods/packs/; mv ~/.rigsofrods/packs/HighQuality04/* -t ~/.rigsofrods/packs/; rmdir ~/.rigsofrods/packs/HighQuality04;;
        [3]* ) exit;;
        * ) echo "Please answer 1,2 or 3";;
    esac
done

echo "You can find more content at http://www.rigsofrods.com/repository/"
echo "Some content may only be found in the forum: http://www.rigsofrods.com/forums/103-Showrooms-and-WIP"
echo "Also check out this list of additional content of high quality: http://www.rigsofrods.com/wiki/pages/High_Quality_Content_not_included_in_the_HQ_Pack"
echo "You may want to delete the downloaded .zips in your home folder"