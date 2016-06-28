#!/bin/bash
# GPLv3

match='.cmd.tex'
echo $0' converts all files that match *'$match

scriptsLoc=/usr/lib/latexBuilderScripts
. $scriptsLoc/.util.sh

function convertLatexCommand { # file that ends with .cmd.tex (this extension allows for syntax high lighting)
  local src=$1
  local outputFile=$2
  echo Entering convertLatexCommand with $src
  if [ -f $src ]; then
    createLatexTag $src $outputFile
  fi
}

function convertLatexCommands {
  local outputFile=$1
  echo Entering convertLatexCommands
  find -name '*'$match | while read file; do convertLatexCommand "$file" "$outputFile"; done
  echo Done converting, see $outputFile for the output and possible empty files
}

convertLatexCommands $outputFile
