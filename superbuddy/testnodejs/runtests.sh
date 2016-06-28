#!/bin/bash
set -e

mountedVolume=/repo
testsCopiedIntoDocker=/usr/lib/defaultTests

if [ -z "$(ls -A "$mountedVolume")" ]; then
  echo 'Error: please use the following syntax;'
  echo -e '\trepo_dir_on_host=. \'
  echo -e '\t&& docker run --rm -it -v $repo_dir_on_host:'$mountedVolume' superbuddy/testnodejs'
  exit
fi

function runScripts {
  local src=$1
  echo Entering $FUNCNAME with $src
  for scrpt in $src/*.sh
  do
    if [ $scrpt"" == $src"/*.sh" ]; then
      echo no shell scripts found
    else
      echo running $scrpt
      $scrpt
    fi
  done
}

cd $mountedVolume
echo "running tests that are specified in the docker"
runScripts $testsCopiedIntoDocker
echo "running tests that are specified in the 'test' folder of the mounted directory"
runScripts $mountedVolume/test