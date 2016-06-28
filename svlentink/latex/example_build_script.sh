#!/bin/bash
# GPLv3

# Place this script in the same dir as your main.tex
texFile=main.tex
dockImg='svlentink/latex'

#http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

function installDocker {
  echo installing docker
  curl -sSL https://get.docker.com/ | sh
  echo creating a user group for docker
  sudo usermod -aG docker $USER
}

function runDocker {
	local texFile=$1
  echo Mounting tmp at tmp, which makes the pdf slides faster by caching
  echo if you changed a slides.pdf file, just rm the folder inside your tmp
	docker run --rm -it -v $DIR:/data -v /tmp:/tmp $dockImg $texFile
}

if [ -z "$(which docker)" ]; then
  installDocker
fi

runDocker $texFile
