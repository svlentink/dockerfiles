#!/bin/bash
set -e
#echo entering $0

HELPMSG="docker run -it --rm \
  svlentink/git \
  -v ~/myRepo:/git
  'firstname surname' \
  user@email.tld \
  commit -m 'lorem ipsum'"

[[ "$#" -lt 3 ]] \
  && echo less than 3 parameters found, please do $HELPMSG \
  && exit 1

UNAME=$1; shift
UMAIL=$1; shift

git config --global user.email "$UMAIL"
git config --global user.name "$UNAME"

! [[ -d /git/.git || ($1 == "init" || $1 == "clone") ]] \
  && echo "no git repo found at /git" && \
  exit 1

git "$@"
