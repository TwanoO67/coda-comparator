#!/bin/bash
default_dir=$HOME'/codaConfig'
if [[ ! -d $default_dir ]]
then
mkdir $default_dir
fi

#Essaye d'executer DiffMerge (verifie presence du fichier)
mergdiff="/Applications/DiffMerge.app/Contents/Resources/diffmerge.sh"
if [[  -f $mergdiff ]]
then
echo 2 > $default_dir/CodaDiffToolPriority.config
nohup osascript -e 'tell app "System Events" to display dialog "DiffMerge will be used!" buttons ["Ok"]  with title "Coda Comparator Plugin"' >/dev/null 2>&1 &
exit
else
nohup osascript -e 'tell app "System Events" to display dialog "DiffMerge is not installed!" buttons ["Ok"]  with title "Coda Comparator Plugin"' >/dev/null 2>&1 &
fi