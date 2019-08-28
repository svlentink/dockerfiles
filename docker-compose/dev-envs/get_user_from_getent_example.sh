#!/bin/bash

USERS_LIST=~/.webide_users.txt

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

# We'll use the hash found in the /etc/shadow file
# for basic auth, which is SHA512 instead of SHA1
# https://security.stackexchange.com/questions/46883/is-every-hash-format-that-nginx-accepts-for-http-basic-auth-weak-against-brute-f
getPasswordHash () {
  local USERNAME="$1"
  local HASH=`getent shadow "$USERNAME"|grep -oE "\\$.+"|sed "s/:.*//g"`
  if [ -n "$HASH" ]; then
    echo "$USERNAME:$HASH:from_shadow_on"`date -I` #nginx accepts comments
  else
    local HASH=`echo -n "$USERNAME"|cut -f1 -d' '`
    echo "$USERNAME:$HASH:md5sum_of_username" #nginx accepts comments
  fi
}

