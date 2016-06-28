#!/bin/bash
# GPLv3

match='_forms'
echo $0' takes on all directories that match *'$match

# You call this script and provide a directory
# inside this directory, multiple directories should be specified,
# which in every dir the various forms.
# E.g. /weeklyReport contains; wk01.tex, wk02.tex etc.
# E.g. /retrospectiveForms contains; 01.tex, 02.tex, 02_01.tex etc.
# This will result in all the forms as one latex tag / command, or whatever you call it;
# use \weeklyReport and \retrospectiveForms to include it

scriptsLoc=/usr/lib/latexBuilderScripts
. $scriptsLoc/.util.sh

function convertFormDir {
	local src=$1 # directory ending with _forms
	local outputFile=$2
	echo Entering convertFormDir with $src
	if ! [[ -d $src ]]; then
		echo This is not a dir, quiting
		exit
	fi
	local lastDir=$(pwd)
	local trimmedDirName=$(basename $src | sed 's/'$match'//g')
	local tmpStore=$tmpDir/$trimmedDirName.tex
	echo '' > $tmpStore
	cd $src

	for f in *.tex
	do
		echo $f found
		if ! [ -f $f ]; then
			echo input is not a file returning
			break
		fi
		cat $f >> $tmpStore
	done
	createLatexTag $tmpStore $outputFile

	cd $lastDir
}

function convertLatexForms {
  local outputFile=$1
  echo Entering convertLatexForms
	find -name '*'$match | while read file; do convertFormDir "$file" "$outputFile"; done
  # find -name '*'$match -exec convertFormDir {} $outputFile \;
  echo Done converting the forms
}

convertLatexForms $outputFile
