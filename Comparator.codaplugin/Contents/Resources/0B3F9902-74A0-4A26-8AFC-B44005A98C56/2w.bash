#!/bin/bash
default_dir=$HOME'/codaConfig'
if [[ ! -d $default_dir ]]
then
mkdir $default_dir
fi
#Forcer l'execution en 2 Way
echo 0 > $default_dir/CodaDiffToolMethod.config
nohup osascript -e 'tell app "System Events" to display dialog "2 Way method will be used!" buttons ["Ok"]  with title "Coda Comparator Plugin"' >/dev/null 2>&1 &
exit