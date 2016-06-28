#!/bin/bash
# GPLv3

function gitCheck { # only runs task when nothing is to be commited
  task=$1

  echo Before this action, everything should be commited using git
  git status #if this fails, it ends here
  if [ -n "$(git status -s)" ]; then
    echo Commit first, not proceeding
  else
    $task
  fi
}

function removeAll {
  local ftype=$1
  local dir=$2

  echo Removing all .$ftype from $dir
  find $dir -name '*.'$ftype -exec rm {} \;
}

function remove {
	echo Entering remove
	echo Removing all .aux files
	find -name '*.aux' -exec rm {} \;
  rm -R $tmpDir
	rm *.out
	rm *.toc
  rm -R *.t2d
  rm *.log
  rm *.aux
  rm *.bak #backup files
}

gitCheck remove
