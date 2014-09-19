#!/bin/bash
default_dir=$HOME'/codaConfig'
if [[ ! -d $default_dir ]]
then
mkdir $default_dir
fi
#Forcer l'execution en 3 Way
echo 1 > $default_dir/CodaDiffToolMethod.config
nohup osascript -e 'tell app "System Events" to display dialog "3 Way method will be used!  (if available with your selected diff tool) " buttons ["Ok"]  with title "Coda Comparator Plugin"' >/dev/null 2>&1 &
exit