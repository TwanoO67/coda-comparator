#!/bin/bash
default_dir=$HOME'/codaConfig'
if [[ ! -d $default_dir ]]
then
mkdir $default_dir
fi
#Essaye d'executer TextWrangler diff (verifie presence du fichier)
twd="/usr/local/bin/twdiff"
if [[  -f $twd ]]
then
echo 16 > $default_dir/CodaDiffToolPriority.config
nohup osascript -e 'tell app "System Events" to display dialog "TextWrangler Diff will be used!" buttons ["Ok"]  with title "Coda Comparator Plugin"' >/dev/null 2>&1 &
exit
else
nohup osascript -e 'tell app "System Events" to display dialog "TextWrangler Diff is not installed! (Dont forget to install CLI tools in TextWrangler)" buttons ["Ok"]  with title "Coda Comparator Plugin"' >/dev/null 2>&1 &
fi