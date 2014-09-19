#!/bin/bash
default_dir=$HOME'/codaConfig'
if [[ ! -d $default_dir ]]
then
mkdir $default_dir
fi
#Essaye d'executer Differencia (verifie presence du fichier)
dcia="/Applications/Differencia.app/Contents/MacOS/Differencia"
if [[  -f $dcia ]]
then
echo 10 > $default_dir/CodaDiffToolPriority.config
nohup osascript -e 'tell app "System Events" to display dialog "Diffenrencia will be used!" buttons ["Ok"]  with title "Coda Comparator Plugin"' >/dev/null 2>&1 &
exit
else
nohup osascript -e 'tell app "System Events" to display dialog "Differencia is not installed!" buttons ["Ok"]  with title "Coda Comparator Plugin"' >/dev/null 2>&1 &
fi