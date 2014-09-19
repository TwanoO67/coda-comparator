#!/bin/bash
#Creation d'un dossier temp
tmpdir="/tmp/CodaComparator"
cur_v=12

#telechargement de la version en cours
last_v=0
mkdir $tmpdir
cd $tmpdir
rm $tmpdir/*

curl -OL http://dl.weberantoine.fr/last_version
if [[ -f $tmpdir/last_version ]]
then
last_v=$(cat $tmpdir/last_version)
fi

if [[ $last_v -gt 0 && $last_v -gt $cur_v ]]
then
nohup osascript -e 'tell app "System Events" to display dialog "A newer version has been found, go to http://dl.weberantoine.fr to install." buttons ["Ok"] with title "Coda Comparator Plugin" ' >/dev/null 2>&1 &
#Attention les nohup sont asynchrones
#nohup osascript -e 'tell app "System Events" to display dialog "A newer version has been found, please press `Replace` in Coda to install." buttons ["Ok"] with title "Coda Comparator Plugin" ' >/dev/null 2>&1 &
#nohup curl -OL http://dl.weberantoine.fr/download.php?file=Comparator_v`echo $last_v`.codaplugin.zip >/dev/null 2>&1 &
#while (ps -A | grep -v grep | grep curl > /dev/null); do sleep 1; done
#nohup unzip download.php?file=Comparator_v* >/dev/null 2>&1 &
#while (ps -A | grep -v grep | grep unzip > /dev/null); do sleep 1; done
#nohup open -a /Applications/Coda\ 2.app Comparator.codaplugin >/dev/null 2>&1 &
else
nohup osascript -e 'tell app "System Events" to display dialog "Your version is up to date" buttons ["Ok"] with title "Coda Comparator Plugin" ' >/dev/null 2>&1 &
fi