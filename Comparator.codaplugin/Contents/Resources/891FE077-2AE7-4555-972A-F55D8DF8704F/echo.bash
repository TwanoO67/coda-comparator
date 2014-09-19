#!/bin/bash

#On verifie la presence de Coda
if [[ ! -d /Applications/Coda\ 2.app ]]
then
nohup osascript -e 'tell app "System Events" to display dialog "Coda path not found!" buttons ["Ok"] with title "Coda #Comparator Plugin" ' >/dev/null 2>&1 &
exit
fi

#on decoupe le nom de fichier
old="$IFS"
IFS="/"
tab=( $CODA_FILEPATH )
IFS="$old"

long=${#tab[*]}
last=$long-1

fin=${tab[$last]}

#determination du chemin local du fichier distant
chemin=$CODA_SITE_LOCAL_PATH
for (( i=0 ; i<${#tab[*]} ; i++ )) ; do
if [[ -d $chemin'/'${tab[$i]} ]]
then

chemin=$chemin'/'${tab[$i]}
fi
done


local=$CODA_SITE_LOCAL_PATH'/'$fin
complet=$chemin'/'$fin

if [[ -f $complet ]]
then
open -a /Applications/Coda\ 2.app "$complet"
exit
else
nohup osascript -e 'tell app "System Events" to display dialog "Local File not found. Verify your Local Root configuration." buttons ["Ok"] with title "Coda Comparator Plugin" ' >/dev/null 2>&1 &
exit
fi

#echo 'file path -> '$CODA_FILEPATH
#echo 'file name -> '$fin
#echo 'local path ->'$CODA_SITE_LOCAL_PATH
#echo 'Possible opening ->'$local
#echo 'Possible complete ->'$complet

