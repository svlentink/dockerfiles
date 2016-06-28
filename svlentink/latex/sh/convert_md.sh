#!/bin/bash
# GPLv3

match='.md'
echo $0' converts all files that match *'$match

# TODO
# Add '-s' or '-D latex' to pandoc
# and include it as pdf http://tex.stackexchange.com/questions/89792/change-document-class-per-page
# to fix a lot of imports etc.

scriptsLoc=/usr/lib/latexBuilderScripts
. $scriptsLoc/.util.sh

function convertMarkdowns {
  local outputFile=$1
  echo Entering convertMarkdowns $outputFile
  local tmp=$tmpDir/markdowns.md
  echo "" > $tmp
  #find -name '*'$match -exec stepInBetweenForMd {} $tmp \;
  #find -name '*'$match | while read file; do stepInBetweenForMd "$file" "$tmp"; done
  mdfiles=$(find -L -name '*'$match)
  echo mdfiles: $mdfiles
  for file in $mdfiles
  do
    stepInBetweenForMd $file $tmp
  done
  convertMarkdown $tmp $outputFile
}
function stepInBetweenForMd {
  local md=$1  # input
  local tmp=$2 # output
  echo Entering stepInBetween with $md and $tmp

  read -n 1 -p "Should we include "$md"? [Y/n] " yn
  if [[ "$yn" == "n" ]]; then
    echo Ok, skipping it.
    return
  fi

  if [ -f $md ]; then
    echo -e "\nSTART include "$md"\n" >> $tmp
    cat $md >> $tmp
    echo -e "\nEND include "$md"\n" >> $tmp
    echo -e '\n\n***\n\n' >> $tmp # create horizontal line
  fi
}
function convertMarkdown {
  local mdfile=$1
  local outputFile=$2
  echo Entering convertMarkdown with $mdfile
  if [ -f $mdfile ]; then
    echo this is a file, which is correct
  else
    echo input is not a file returning
    return
  fi

  #do not include the --chapters argument!
  local nakedName=$(removeExtension $mdfile)
  local tmp=$tmpDir/$nakedName.tex
  local pdfFile=$tmpDir/$nakedName.pdf
  echo "" > $tmp

  echo running pandoc with $mdfile and outputing to $pdfFile
  pandoc -f markdown -o $pdfFile $mdfile

  pdfToImgs $pdfFile $tmp
  echo -e '\n\\newpage' >> $tmp
  createLatexTag $tmp $outputFile
}

convertMarkdowns $outputFile
