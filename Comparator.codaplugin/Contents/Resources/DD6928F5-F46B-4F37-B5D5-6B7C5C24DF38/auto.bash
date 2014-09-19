#!/bin/bash
default_dir=$HOME'/codaConfig'
if [[ ! -d $default_dir ]]
then
mkdir $default_dir
fi

echo 0 > $default_dir/CodaDiffToolPriority.config
nohup osascript -e 'tell app "System Events" to display dialog "Automatic diff selection will be used." buttons ["Ok"] with title "Coda Comparator Plugin" ' >/dev/null 2>&1 &
exit