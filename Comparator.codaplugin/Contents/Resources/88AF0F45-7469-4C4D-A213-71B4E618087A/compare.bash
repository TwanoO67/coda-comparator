#!/bin/bash
default_dir=$HOME'/codaConfig'
if [[ ! -d $default_dir ]]
then
mkdir $default_dir
fi

#chemin des fichiers utiliser
fichier_gauche=$default_dir"/CodaCompareFile_Left.tmp"
fichier_droit=$default_dir"/CodaCompareFile_Right.tmp"
fichier_merge=$default_dir"/CodaCompareFile_Merge.tmp"

#chemin des config
config_tool=$default_dir"/CodaDiffToolPriority.config"
config_method=$default_dir"/CodaDiffToolMethod.config"
config_merge=$default_dir"/CodaDiffMergeMethod.config"

#On verifie la presence de fichier à comparer
if [[ ! -f $fichier_gauche ]]
then
nohup osascript -e 'tell app "System Events" to display dialog "No 'Left' file selected!" buttons ["Ok"] with title "Coda Comparator Plugin" ' >/dev/null 2>&1 &
exit
else
if [[ ! -f $fichier_droit ]]
then
nohup osascript -e 'tell app "System Events" to display dialog "No 'Right' file selected!" buttons ["Ok"] with title "Coda Comparator Plugin" ' >/dev/null 2>&1 &
exit
fi
fi

#On verifie si une priorite est definie manuellement
priorite=0
modeforcer=0
if [[ -f $config_tool ]]
then
priorite=$(cat $config_tool)
if [[ $priorite -gt 0 ]]
then
modeforcer=1
fi
fi

#On verifie si une methode est définie manuelle (default = 0  pour 2 Way)
diffmethod=0
if [[ -f $config_method ]]
then
diffmethod=$(cat $config_method)
fi

#Si on fait un 3-Way on regarde comment preparer le Merge (default = 2 pour Right)
mergemethod=2
#verification si une methode pour le merge est precisée
if [[ -f $config_merge ]]
then
mergemethod=$(cat $config_merge)
fi

#preparation du fichier a merger
if [[ $mergemethod -eq 0 ]]
then
echo '' > $fichier_merge
else
if [[ $mergemethod -eq 1 ]]
then
cp $fichier_gauche $fichier_merge
else
if [[ $mergemethod -eq 2 ]]
then
cp $fichier_droit $fichier_merge
fi
fi
fi

#Si il existe un script perso
configperso=$(which codacomparediff)
if [[ $priorite -eq 0 && "${#configperso}" -gt 0 && -f $configperso ]]
then
nohup $configperso >/dev/null 2>&1 &
exit
else
if [[ $modeforcer -eq 0 ]]
then
priorite=1
fi
fi

#Essaye d'executer XCode FileMerge (verifie taille du chemin et presence du fichier)
xcodediff=$(which opendiff)
if [[ $priorite -eq 1 && "${#xcodediff}" -gt 0 && -f $xcodediff ]]
then
nohup $xcodediff $fichier_gauche $fichier_droit -merge $fichier_merge >/dev/null 2>&1 &
exit
else
if [[ $modeforcer -eq 0 ]]
then
priorite=2
fi
fi

#Essaye d'executer DiffMerge (verifie presence du fichier)
mergdiff="/Applications/DiffMerge.app/Contents/Resources/diffmerge.sh"
if [[ $priorite -eq 2 && -f $mergdiff ]]
then
#2 Way
if [[ $diffmethod -eq 0 ]]
then
nohup $mergdiff $fichier_gauche $fichier_droit >/dev/null 2>&1 &
exit
fi
#3 Way
if [[ $diffmethod -eq 1 ]]
then
nohup $mergdiff $fichier_gauche $fichier_droit -merge $fichier_merge >/dev/null 2>&1 &
exit
fi

else
if [[ $modeforcer -eq 0 ]]
then
priorite=3
fi
fi

#Essaye d'executer Kaleidoscope (verifie taille du chemin et presence du fichier)
kaldiff=$(which ksdiff)
if [[ "${#kaldiff}" -gt 0 ]]
then
kdiff=$kaldiff
else
kdiff="/usr/local/bin/ksdiff"
fi

if [[ $priorite -eq 3 && -f $kdiff ]]
then
#2 Way
if [[ $diffmethod -eq 0 ]]
then
nohup $kdiff --diff $fichier_gauche $fichier_droit >/dev/null 2>&1 &
exit
fi
#3 Way
if [[ $diffmethod -eq 1 ]]
then
nohup $kdiff --merge --output $fichier_merge $fichier_gauche $fichier_droit >/dev/null 2>&1 &
exit
fi

else
if [[ $modeforcer -eq 0 ]]
then
priorite=4
fi
fi

#Essaye d'executer VimDiff (verifie taille du chemin et presence du fichier)
vdiff=$(which vimdiff)
if [[ $priorite -eq 4 && "${#vdiff}" -gt 0 && -f $vdiff ]]
then
#2 Way
if [[ $diffmethod -eq 0 ]]
then
osascript <<END
tell application "Terminal"
do script "vimdiff $fichier_gauche $fichier_droit;exit"
activate
set bounds of window 1 to {160, 80, 980, 700}
end tell
END
exit
fi
#3 Way
if [[ $diffmethod -eq 1 ]]
then
echo '' > $fichier_merge
cp $fichier_droit $fichier_merge
osascript <<END
tell application "Terminal"
do script "vimdiff $fichier_gauche $fichier_droit $fichier_merge;exit"
activate
set bounds of window 1 to {160, 80, 980, 700}
end tell
END
exit
fi
else
if [[ $modeforcer -eq 0 ]]
then
priorite=5
fi
fi

#Essaye d'executer Diff (verifie taille du chemin et presence du fichier)
difft=$(which diff)
if [[ $priorite -eq 5 && "${#difft}" -gt 0 && -f $difft ]]
then
osascript <<END
tell application "Terminal"
do script "diff -upb $fichier_gauche $fichier_droit;exit"
activate
set bounds of window 1 to {160, 80, 980, 700}
end tell
END
exit
else
if [[ $modeforcer -eq 0 ]]
then
priorite=6
fi
fi

#Essaye d'executer KDiff3 (verifie presence du fichier)
kkdiff="/Applications/kdiff3.app/Contents/MacOS/kdiff3"
if [[ $priorite -eq 6 && -f $kkdiff ]]
then
#2 Way
if [[ $diffmethod -eq 0 ]]
then
nohup $kkdiff $fichier_gauche $fichier_droit >/dev/null 2>&1 &
exit
fi
#3 Way
if [[ $diffmethod -eq 1 ]]
then
nohup $kkdiff $fichier_gauche $fichier_droit -o $fichier_merge >/dev/null 2>&1 &
exit
fi
else
if [[ $modeforcer -eq 0 ]]
then
priorite=7
fi
fi

#Essaye d'executer p4merge (verifie presence du fichier)
p4m="/Applications/p4merge.app/Contents/Resources/launchp4merge"
if [[ $priorite -eq 7 && -f $p4m ]]
then
nohup $p4m $fichier_gauche $fichier_droit >/dev/null 2>&1 &
exit
else
if [[ $modeforcer -eq 0 ]]
then
priorite=8
fi
fi

#Essaye d'executer Araxis Merge (verifie presence du fichier)
arax='/Applications/Araxis Merge.app/Contents/Utilities/compare'
if [[ $priorite -eq 8 && -f $arax ]]
then
cd /Applications/Araxis\ Merge.app/Contents/Utilities/
#2 Way
if [[ $diffmethod -eq 0 ]]
then
nohup ./compare $fichier_gauche $fichier_droit >/dev/null 2>&1 &
exit
fi
#3 Way
if [[ $diffmethod -eq 1 ]]
then
nohup ./compare $fichier_gauche $fichier_droit $fichier_merge >/dev/null 2>&1 &
exit
fi
else
if [[ $modeforcer -eq 0 ]]
then
priorite=9
fi
fi

#Essaye d'executer RoaringDiff (verifie presence du fichier)
roar="/Applications/RoaringDiff.app/Contents/MacOS/RoaringDiff"
if [[ $priorite -eq 9 && -f $roar ]]
then
nohup $roar $fichier_gauche $fichier_droit >/dev/null 2>&1 &
exit
else
if [[ $modeforcer -eq 0 ]]
then
priorite=10
fi
fi

#Essaye d'executer Differencia (verifie presence du fichier)
dcia="/Applications/Differencia.app/Contents/MacOS/Differencia"
if [[ $priorite -eq 10 && -f $dcia ]]
then
nohup $dcia $fichier_gauche $fichier_droit >/dev/null 2>&1 &
exit
else
if [[ $modeforcer -eq 0 ]]
then
priorite=11
fi
fi

#Essaye d'executer DeltaWalker
dw="/Applications/DeltaWalker.app/Contents/MacOS/dw"
if [[ $priorite -eq 11 && -f $dw ]]
then
#2 Way
if [[ $diffmethod -eq 0 ]]
then
nohup $dw $fichier_gauche $fichier_droit >/dev/null 2>&1 &
exit
exit
fi
#3 Way
if [[ $diffmethod -eq 1 ]]
then
nohup $dw $fichier_gauche $fichier_droit $fichier_merge >/dev/null 2>&1 &
exit
fi
else
if [[ $modeforcer -eq 0 ]]
then
priorite=12
fi
fi

#Essaye d'executer guiffy(verifie presence du fichier)
gf="./guiffyCL.command"
cd /Applications/guiffy*
if [[ $priorite -eq 12 && -f $gf ]]
then
nohup $gf $fichier_gauche $fichier_droit >/dev/null 2>&1 &
exit
else
if [[ $modeforcer -eq 0 ]]
then
priorite=13
fi
fi

#Essaye d'executer DiffFork (verifie presence du fichier)
dff="/Applications/DiffFork.app/Contents/SharedSupport/Support/bin/difffork"
if [[ $priorite -eq 13 && -f $dff ]]
then
nohup $dff $fichier_gauche $fichier_droit >/dev/null 2>&1 &
exit
else
if [[ $modeforcer -eq 0 ]]
then
priorite=14
fi
fi

#Essaye d'executer ECMerge (verifie presence du fichier)
ec="/Applications/ECMerge.app/Contents/MacOS/guimerge"
if [[ $priorite -eq 14 && -f $ec ]]
then
#2 Way
if [[ $diffmethod -eq 0 ]]
then
nohup $ec $fichier_gauche $fichier_droit >/dev/null 2>&1 &
exit
fi
#3 Way
if [[ $diffmethod -eq 1 ]]
then
nohup $ec $fichier_gauche $fichier_droit -o $fichier_merge >/dev/null 2>&1 &
exit
fi
else
if [[ $modeforcer -eq 0 ]]
then
priorite=15
fi
fi

#Essaye d'executer Changes (verifie presence du fichier)
chg="/Applications/Changes.app/Contents/Resources/chdiff"
if [[ $priorite -eq 15 && -f $chg ]]
then
nohup $chg $fichier_gauche $fichier_droit >/dev/null 2>&1 &
exit
else
if [[ $modeforcer -eq 0 ]]
then
priorite=16
fi
fi

#Essaye d'executer TextWrangler's diff (verifie presence du fichier)
twdiff="/usr/local/bin/twdiff"
if [[ $priorite -eq 16 && -f $twdiff ]]
then
nohup $twdiff $fichier_gauche $fichier_droit >/dev/null 2>&1 &
exit
else
if [[ $modeforcer -eq 0 ]]
then
priorite=17
fi
fi

if [[ $modeforcer -eq 0 ]]
then
nohup osascript -e 'tell app "System Events" to display dialog "No DiffTool installed!" buttons ["Ok"] with title "Coda Comparator Plugin" ' >/dev/null 2>&1 &
else
nohup osascript -e 'tell app "System Events" to display dialog "The selected Diff tool is not installed, please select another one." buttons ["Ok"] with title "Coda Comparator Plugin" ' >/dev/null 2>&1 &
fi