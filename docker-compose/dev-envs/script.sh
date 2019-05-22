#!/bin/bash

USERS_LIST=~/.webide_users.txt

which podman && docker=podman && echo Using podman instead of docker

ALLUSERS=`getent passwd|grep bash|grep -oE '^[0-9a-z]*'`
USERCOUNT=`echo $ALLUSERS|wc -l`

touch $USERS_LIST
if [ -s $USERS_LIST ]; then
  echo We use the users found in $USERS_LIST
else
  read -n1 -p "Found $USERCOUNT users, iterate over them? [Y/n]" ynq1
  if [[ "$ynq1" == [Yy] ]]; then
    for u in "$ALLUSERS"; do
      read -n1 -p "Use $u? [Y/n]" ynq2
      [[ "$ynq2" == [Yy] ]] && echo $u >> $USERS_LIST
    done
  fi
fi

