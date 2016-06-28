#!/bin/bash
# GPLv3
# I do not use this anymore, but some may find it useful

function indent {
	echo Entering indent
  if [ -d latexindent ]; then
    find . -name "*.tex" -writable -type f -exec latexindent/latexindent.pl -w -s {} \;
  else
    wget http://mirrors.ctan.org/support/latexindent.zip
    unzip latexindent.zip
    mv latexindent.zip /tmp/latexindent.zip
    indent
  fi
}

indent # you could use the gitcheck found in rm.sh
