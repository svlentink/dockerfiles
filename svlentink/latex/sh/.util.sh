#!/bin/bash
# GPLv3

#http://stackoverflow.com/questions/10823635/how-to-include-file-in-a-bash-shell-script
scriptsLoc=/usr/lib/latexBuilderScripts
. $scriptsLoc/.config.sh
cd $mountedVolume #specified in .config.sh

if [ -d $tmpDir ]; then
  echo $tmpDir allready exists
else
  echo creating $tmpDir
  mkdir $tmpDir
fi

function preZeros {
  local i=$1
  local max=$2
  printf "%0*d\n" ${#max} $i
}

if [ -z "$createLatexTagCounter" ]; then
  createLatexTagCounter=0
fi
function count {
  createLatexTagCounter=$(($createLatexTagCounter+1))
}
function printCount {
  echo $(preZeros $createLatexTagCounter 99999) #create preceding zeros
}

function removeExtension {
  local complete=$(basename $1)
  local filename="${complete%.*}"
  if [[ $filename == *[\.]* ]]; then
    local filename=$(removeExtension $filename) # loop recursively; for example: *.cmd.tex
  fi
  echo $filename
}

# Tag maybe a bad name, it's derived from html tag, like <section> or <hr/>
# we could call it a command or newcommand in LaTeX
function createLatexTag { #make sure the filename does not contain numbers!
  local outputFile=$2
  local contentsrc=$1
  echo Entering createLatexTag with $contentsrc and $outputFile
  local filename=$(removeExtension $contentsrc)
  local withoutUnderscore="$(echo -e "${filename}" | tr -d '[[_]]')"
  if [ -z "$(cat $contentsrc)" ]; then
#    echo empty command for $withoutUnderscore
    echo '\newcommand{\'$withoutUnderscore'}{}' >> $outputFile
  else
#    echo creating command $withoutUnderscore
    echo '\newcommand{\'$withoutUnderscore'}{\createLatexTagCount{'$(printCount)'}{'$withoutUnderscore'}%the counter allows for debugging, checking if all are included!' >> $outputFile
    count
    # echo -e $(cat $f)'' >> $tmpfile
    cat $contentsrc >> $outputFile
    # since a comment may end with its last line (or only line) containing a comment
    # the closing bracket will be commented out
    # to cope with this problem, and still prevent the trailing white space,
    # we use the following line
    echo -e '%\n}' >> $outputFile
  fi
}

# TODO
# Convert this code to use \includepdf
# as explained: http://tex.stackexchange.com/questions/105589/insert-pdf-file-in-latex-document
function pdfToImgs {
	local file=$1
	local latexOutputDest=$2
	local dir=$tmpDir
	local imgDir=autogenImgs
	echo Entering pdfToImgs with $file
	if ! [[ -d $dir/$imgDir ]]; then
		mkdir $dir/$imgDir
	fi
	echo extracting the images from $file
	echo current PWD $PWD
  local imgPre=$dir/$imgDir/$(removeExtension $file)
  echo the images will be prefixed by $imgPre
	pdftoppm -png $file $imgPre
	echo images are extracted

	echo Starting looping through pictures
	for p in $dir/$imgDir/$(removeExtension $file)*.png
	do
		echo found $p
		if [ -f $p ]; then
			echo "\\includegraphics[width=1.1\textwidth]{"$p"}" >> $tmp
		else
			echo ERROR $p not a file
		fi
	done
}
