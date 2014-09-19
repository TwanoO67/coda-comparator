#!/bin/bash
default_dir=$HOME'/codaConfig'
if [[ ! -d $default_dir ]]
then
mkdir $default_dir
fi
#Essaye d'executer RoaringDiff (verifie presence du fichier)
roar="/Applications/RoaringDiff.app/Contents/MacOS/RoaringDiff"
if [[  -f $roar ]]
then
echo 9 > $default_dir/CodaDiffToolPriority.config
nohup osascript -e 'tell app "System Events" to display dialog "RoaringDiff will be used!" buttons ["Ok"]  with title "Coda Comparator Plugin"' >/dev/null 2>&1 &
exit
else
nohup osascript -e 'tell app "System Events" to display dialog "RoaringDiff is not installed!" buttons ["Ok"]  with title "Coda Comparator Plugin"' >/dev/null 2>&1 &
fi