#!/bin/bash
default_dir=$HOME'/codaConfig'
if [[ ! -d $default_dir ]]
then
mkdir $default_dir
fi
#Essaye d'executer Araxis Merge (verifie presence du fichier)
arax="/Applications/Araxis Merge.app/Contents/Utilities/compare"
if [[  -f $arax ]]
then
echo 8 > $default_dir/CodaDiffToolPriority.config
nohup osascript -e 'tell app "System Events" to display dialog "Araxis Merge will be used!" buttons ["Ok"]  with title "Coda Comparator Plugin"' >/dev/null 2>&1 &
exit
else
nohup osascript -e 'tell app "System Events" to display dialog "Araxis Merge is not installed!" buttons ["Ok"]  with title "Coda Comparator Plugin"' >/dev/null 2>&1 &
fi