#!/bin/bash
default_dir=$HOME'/codaConfig'
if [[ ! -d $default_dir ]]
then
mkdir $default_dir
fi
#Essaye d'executer Kaleidoscope (verifie taille du chemin et presence du fichier)
kaldiff=$(which ksdiff)
if [[ "${#kaldiff}" -gt 0 ]]
then
kdiff=$kaldiff
else
kdiff="/usr/local/bin/ksdiff"
fi

if [[ -f $kdiff ]]
then
echo 3 > $default_dir/CodaDiffToolPriority.config
nohup osascript -e 'tell app "System Events" to display dialog "Kaleidoscope will be used!" buttons ["Ok"]  with title "Coda Comparator Plugin"' >/dev/null 2>&1 &
exit
else
nohup osascript -e 'tell app "System Events" to display dialog "Kaleidoscope CLI is not installed!" buttons ["Ok"]  with title "Coda Comparator Plugin"' >/dev/null 2>&1 &
fi

