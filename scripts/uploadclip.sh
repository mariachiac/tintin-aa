#!/bin/bash

#vclip by Storm Dragon
#License: WTFPL http://wtfpl.net/
#This script makes recording and pasting sound clips to Alter Aeon's sound clip channel easier.

#Mac compatability, hopefully
if [ "$(uname)" == "Darwin" ]; then
sedCmd="gsed"
else
sedCmd="sed"
fi
grepCmd="grep"
# Path where clips are stored:
clipPath="${XDG_CONFIG_HOME:-$HOME/.config}/tintin-alteraeon"

#Reduce file size for faster uploads, and to be nice to the sndup server
sox $clipPath/clip.ogg -c 1 -r 17088 $clipPath/tmpclip.ogg norm
mv $clipPath/tmpclip.ogg $clipPath/clip.ogg
#upload the file and extract the url from the json
upload="$(curl -s --form file=@$clipPath/clip.ogg --form submit=upload http://sndup.net/post.php)"
jsonInfo="$(echo "$upload" | $sedCmd 's/,/\n/g')"
#save channel command to the file and show link in the terminal
echo -n "$@ " > $clipPath/cliplink.txt
echo -n "$jsonInfo" | $grepCmd 'url' | $sedCmd -e 's/^{"url":"//' -e 's/a$/d/' | tr -d '"\\' >> $clipPath/cliplink.txt
exit 0
