#!/bin/bash
default_dir=$HOME'/codaConfig'
if [[ ! -d $default_dir ]]
then
mkdir $default_dir
fi
#Choix de la facon de remplir le merge au depart
echo 2 > $default_dir/CodaDiffMergeMethod.config
nohup osascript -e 'tell app "System Events" to display dialog "The Merge file initial state will be a copy of the Right File." buttons ["Ok"]  with title "Coda Comparator Plugin"' >/dev/null 2>&1 &
exit