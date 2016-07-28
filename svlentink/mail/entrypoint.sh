#!/bin/bash
set -e

echo checking if port 25 is open
nc -z -w1 smtp.gmail.com 25
echo port 25 is open

/etc/init.d/postfix start

function sendmailfunc { #sendmail is already used! (/usr/sbin/sendmail)
  local to=$1; shift
  local from=$1; shift
  local subj=$1; shift
  local body=$@
  echo Entering $FUNCNAME with: to=$to, from=$from, subj=$subj, body=$body

  [[ -z "$body" ]] && echo "ERROR: Empty body" && exit 1

  echo $body | mail -s "$subj" --debug-level 7 -a 'From:'$from $to
  echo Running a sleep command so the mail can actually be send by the daemon
  local i=1
  while [ "$(sendmail -bp)" != "Mail queue is empty" ]; do
    [[ $i == 10 ]] && echo Checked too many times, it just failed && exit 1
    echo checking for $i th time
    local i=$(($i+1))
    sendmail -bp
    sleep 1
  done
  echo Mail send
}

sendmailfunc "$@"
exit 0
