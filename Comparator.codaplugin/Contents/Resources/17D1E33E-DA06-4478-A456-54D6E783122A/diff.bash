#!/bin/bash
default_dir=$HOME'/codaConfig'
if [[ ! -d $default_dir ]]
then
mkdir $default_dir
fi
#Essaye d'executer Diff
diff=$(which diff)
if [[ "${#diff}" -gt 0 && -f $diff ]]
then
echo 5 > $default_dir/CodaDiffToolPriority.config
nohup osascript -e 'tell app "System Events" to display dialog "Diff will be used!" buttons ["Ok"]  with title "Coda Comparator Plugin"' >/dev/null 2>&1 &
exit
else
nohup osascript -e 'tell app "System Events" to display dialog "Diff is not installed!" buttons ["Ok"]  with title "Coda Comparator Plugin"' >/dev/null 2>&1 &
fi