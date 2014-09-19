#!/bin/bash
default_dir=$HOME'/codaConfig'
if [[ ! -d $default_dir ]]
then
mkdir $default_dir
fi

#on verifie la methode de comparaison
diffmethod=0
if [[ -f $default_dir/CodaDiffToolMethod.config ]]
then
diffmethod=$(cat $default_dir/CodaDiffToolMethod.config)
fi

if [[ $diffmethod -eq 0 ]]
then
nohup osascript -e 'tell app "System Events" to display dialog "You should select the 3-Way diff method to create a Merge file" buttons ["Ok"] with title "Coda Comparator Plugin" ' >/dev/null 2>&1 &
exit
fi

#On verifie la presence de fichier à comparer
if [[ ! -f $default_dir/CodaCompareFile_Merge.tmp ]]
then
nohup osascript -e 'tell app "System Events" to display dialog "No Merge file found!" buttons ["Ok"] with title "Coda Comparator Plugin" ' >/dev/null 2>&1 &
exit
else
cat $default_dir/CodaCompareFile_Merge.tmp
fi