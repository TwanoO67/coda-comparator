coda-comparator
===============

Coda2's Plugin - [Comparator](http://dl.weberantoine.fr) - by [Weber Antoine](mailto:pro@weberantoine.fr)
--------------------
Comparator: Coda 2 IDE Plugin to compare 2 files

How to setup the 'Comparator' plugin ?
--------------------
With FileMerge from XCode
* Install XCode
* Open it (at least one time) to accept the license agreement
* Define the path to XCode XCode:
	`sudo xcode-select -switch /Applications/Xcode.app`

* try it in terminal `sudo /usr/bin/opendiff `
    if the setup is good, this should respond 'too few arguments'

**With Kaleidoscope from BlackPixel**

* Install Kaleidoscope
* Open it and go to "Kaleidoscope>Integration" to install 'Command lines tool ksdiff'
	
**With TextWrangler's diff from Barebones**

* Install TextWrangler
* Open it and go to menu "TextWrangler>Install Command lines tool'


**With other supported tool**

* Select it in the Menu 'Plugins -> Comparator -> Choose DiffTool'

    		
How to add another diff tool
--------------------

* Install your tool (and CLI) 
* Create a shell script that execute your tool with the parameters to open the good files in /tmp/CodaCompareFile_<>.tmp
* Make it executable
* Create a symlink to replace the default tool used by comparator
	`sudo ln -s /tmp/yourscript.sh /usr/local/bin/codacomparediff`

How to use 'Comparator' plugin?
--------------------

*  Open the first file to compare 
	` Menu 'Plug-ins -> Comparator -> Use to Compare Left' (or cmd+1)`

*  Open the second file to compare (not necessarily on the same Coda instance)
	` Menu 'Plug-ins -> Comparator -> Use to Compare Right' (or cmd+2)`

*  Open the diff tool to Compare
	` Menu 'Plug-ins -> Comparator -> Compare (Left & Right)' (or cmd+#)`


*  Make your choices between Left & Right differences [and 'Save' the merge (or cmd+s)]
	``


*  Open the file in which you want to import the result and replace his content
	` Menu 'Plug-ins -> Comparator -> Replace current with the merge' (or cmd+3)`
    				

How to use the function 'Open in local root dir' ?
--------------------
    		
* Define the 'Local Root' of your project
  `(e.g /Users/you/Documents/localsite/mysite )`

* Open a file from your remote folder 
  `(e.g /httpdocs/mysite/folderA/fileName.php )`

* Click on Menu 'Plug-ins -> Comparator -> Open in local root dir'
  `it will open your local file (e.g /Users/you/Documents/localsite/mysite/folderA/fileName.php )`

* Warning: This options actually work only with both local and remote dir on your local host (no remote host for the moment)
    		  
How to change shortcuts of the plugin  --------------------
    		
* Download <a href='http://panic.com/coda/d/Coda%20Plug-in%20Creator.zip' >Coda Plugin Creator</a> 
* Open the plugin 'Comparator' with 'Coda Plugin Creator'
* Change the keys, for the shortcuts you want. Then 'Save' the new plugin.
* Open the new plugin you just created with 'Coda'. When asked, choose 'overwrite the plugin'. 

What's the default launch order for diff tools --------------------
    		
Coda comparator plugin will launch the first diff tool it finds in this order :
* your own script (if you have a symlink 'codacomparediff' in your /usr/local/bin) 
* File Merge from XCode
* DiffMerge from SourceForge
* Kaleidoscope CLI from BlackPixel
* VimDiff in Terminal
* Diff in Terminal
* KDiff3 from Joachim Eibl
* P4Merge from Perforce
* Merge from Araxis
* RoaringDiff from Biscade
* Differencia from DaytimeSoftware
* DeltaWalker from Deltopia
* Guiffy from GuiffySoftware
* DiffFork from DotFork
* ECMerge from ElliéComputing
* Changes from BitBQ

plugin written by [Weber Antoine](http://www.weberantoine.fr) 2012, Questions/Improvements ? [mail me!](mailto:pro@weberantoine.fr)