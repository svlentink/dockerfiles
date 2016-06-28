#!/bin/bash
# GPLv3

scriptsLoc=/usr/lib/latexBuilderScripts # this is where the Dockerfile placed them
. $scriptsLoc/.config.sh

if [ -z "$(ls -A "$mountedVolume")" ]; then
  echo 'Error: please use the following syntax;'
  echo -e '\tsrc_dir_on_host=. \'
  echo -e '\ttex_file_to_be_compiled=main.tex \'
  echo -e '\t&& docker run --rm -it -v $src_dir_on_host:'$mountedVolume' svlentink/latex $tex_file_to_be_compiled'
  exit
fi

function build {
  local inp=$1

# The following was a attempt on getting the the table of contents small,
# but the result would be that the numbering continued, which
# results in the toc inside your pdf reader displaying everything
#    sed -i "s/tocdepth}{/tocdepth}{7} %/g" main.tex
#    texi2pdf main.tex
#    texi2pdf main.tex
#    sed -i 's/tocdepth}{7} %/tocdepth}{/g' main.tex

  echo clearing $outputFile
  echo '' > $outputFile
  runScripts $scriptsLoc
  if [ -d $mountedVolume/sh ]; then # for custom scripts and easier debugging
    runScripts $mountedVolume/sh
  fi
  cd $mountedVolume #without this step, the file is compiled, but the pdf is never leaving the docker
  texi2pdf --tidy --shell-escape $mountedVolume/$inp
}
# Run the scripts that are copied into the docker by the Dockerfile
function runScripts {
  local src=$1
  for scrpt in $src/*.sh
  do
    case $scrpt in
#      *convert.* ) echo running $scrpt; $scrpt ;; #does not work
      * ) read -n 1 -p "Should we run "$scrpt"? [Y/n] " yn; \
        if [ $yn == "y" ]; then \
          $scrpt; \
        else \
          echo ok, not running it; \
        fi ;;
    esac
  done
}
function showHelp {
  echo We generate a lot of latex newcommands,
  echo which you should include using
  echo -e '\t\input{'$outputFile'}'
  echo just below the documentclass statement
}

case $1 in
  [\-]* ) showHelp;;  # getopts not needed
  * )     build $@;;
esac
