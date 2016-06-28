#!/bin/bash
# GPLv3

scriptsLoc=/usr/lib/latexBuilderScripts
. $scriptsLoc/.util.sh

function convertDocs {
  local src=$1
	local outputFile=$2
	echo Entering convertDocs
	for d in $src/*
	do
		convertDoc $d $outputFile
	done
}
function convertDoc { #this function can be optimized, check if pictures are already there, then conversion is not needed (md5sum)
  local file=$1
	local outputFile=$2
	echo Entering convertDoc with $file
	if [ -f $file ]; then
		echo this is a file, which is correct
	else
		echo input is not a file returning
		return
	fi
  echo "converting document ("$file") to pdf, current pwd "$(pwd)
  loffice --headless --convert-to pdf $file
  echo extracting imgs
  local name=$(removeExtension $file)
  local pdfname=$(pwd)/$name".pdf" # the pwd of the loffice matters here
	local tmp=$tmpDir/$(removeExtension $file).tex
	echo "" > $tmp
  pdfToImgs $pdfname $tmp
	echo done converting, removing the pdf
	rm $pdfname
	createLatexTag $tmp $outputFile
}

convertDocs $docsDir $outputFile
