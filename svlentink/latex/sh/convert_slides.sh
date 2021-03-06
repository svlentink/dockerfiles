#!/bin/bash
# GPLv3

match='.slides.pdf'
echo $0' converts all files that match *'$match

scriptsLoc=/usr/lib/latexBuilderScripts
. $scriptsLoc/.util.sh

function convertSlides {
  local outputFile=$1
  echo Entering convertSlides
  #find -name '*'$match -exec pdfWithSlidesToLatex {} $outputFile \;
  find -name '*'$match | while read file; do pdfWithSlidesToLatex "$file" "$outputFile"; done
}
function pdfWithSlidesToLatex {
  local pdf=$1
  local outputFile=$2
  echo Entering pdfWithSlidesToLatex with $pdf
  if [ -f $pdf ]; then
    echo this is a file, which is correct
  else
    echo input is not a file returning
    return
  fi
  local tmp=$tmpDir/$(removeExtension $pdf).tex
  echo clearing $tmp
  echo "" > $tmp
  local imgDirName=$tmpDir/$(removeExtension $pdf)
  if [[ -d $imgDirName ]]; then
    echo directory already existed, using cache
  else
    mkdir $imgDirName
  fi

#  echo creating directory for the images of $pdf
#  mkdir $imgDirName
#  cd $imgDirName

  local filename=$(removeExtension $pdf)
  local withoutUnderscore="$(echo -e "${filename}" | tr -d '[[_]]')"
  if [[ -n $(ls $imgDirName | grep png) ]]; then
    echo PDF has been converted already, using cache from $imgDirName
    echo To recompile it, clear the cache
  else # This operation is very slow!
    echo extracting the images from $pdf
    pdftoppm -png $pdf $imgDirName/$withoutUnderscore
    echo images are extracted
  fi

  echo creating latex table rows
  local tex=$tmp # $imgDirName.tex
  local imgPath=$imgDirName
  local tabuStart='\begin{tabu} to \linewidth { X[l] | X[r]} \hline'

  echo '\h{3}{Slides from '$withoutUnderscore'}{This table has been auto generated by script, for more info github.com/svlentink/latex\_docker}' > $tex
  echo $tabuStart >> $tex
  local left='' #left side image
  local imgLatexCode='\includegraphics[width=0.48\textwidth]{' #$imgPath/
  local i=1
  echo Starting looping through the images in $imgPath
  for p in $imgPath/*.png
  do
    echo found $p
    if [ $i == 9 ]; then #max 8 slides on a page
      echo '\end{tabu} \newpage '$tabuStart >> $tex
      local i=1
    fi
    local i=$(($i+1))

    if [ -z "$left" ]; then
      #first of pair
      left=$p
    else #only works for even amount of slides
      #second of pair
      echo $(removeExtension $left)' & '$(removeExtension $p)' \\' >> $tex
      echo $imgLatexCode$left'} &' >> $tex
      echo $imgLatexCode$p'} \\ \hline' >> $tex
      left=''
    fi
  done
  echo done looping

  if [ -n "$left" ]; then
    #uneven amount of slides
    echo $(removeExtension $left)' \\' >> $tex
    echo $imgLatexCode$left'} \\ \hline' >> $tex
  fi
  echo '\end{tabu} \newpage' >> $tex
#  cd ..
  createLatexTag $tmp $outputFile
}

convertSlides $outputFile
