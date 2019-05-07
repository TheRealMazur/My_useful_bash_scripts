#!/bin/bash
#Napiprojekt Subtitles download by ID
#Here's a crude script which allows you to download movie subtitles from Napiprojekt servers by their ID.
#Just run it whit the ID as parameter :
#"$./NapiprojektSubtitlesDownloader d05ce44cda59d7ab5217aae63f1da8dc"
temp=$(curl -X POST -s -F mode=17 -F client=NapiProjekt -F downloaded_subtitles_id=$1 http://napiprojekt.pl/api/api-napiprojekt3.php)
temp=$( echo $temp | grep -oE "<content>.*</content>")
temp=$( echo $temp | sed -e 's|<content><!\[CDATA\[||1')
temp=$( echo $temp | sed -e 's|\]\]></content>||1')
echo $temp >> temp.7z
base64 -d temp.7z >> dec.7z
7z e -y -bso0 -bsp0 -p"iBlm8NTigvru0Jr0" -o"." "dec.7z"
rm temp.7z dec.7z