#!/bin/bash
set -e

BODYLOC=/body

echo checking if port 25 is open
nc -z -w1 smtp.gmail.com 25
echo port 25 is open

/etc/init.d/postfix start

[[ -z "$TO_ADDR" ]] && echo Usage: see https://hub.docker.com/r/svlentink/mail && exit 1

FROM_HEADER="From: $FROM_NAME <$FROM_ADDR>"
echo "Starting to send message '$SUBJ' to $TO_ADDR ($FROM_HEADER)"

if [[ -f $BODYLOC ]]; then
  cat $BODYLOC | mail -s "$SUBJ" --debug-level 7 -a "$FROM_HEADER" $TO_ADDR
else
  echo -e "$@" | mail -s "$SUBJ" --debug-level 7 -a "$FROM_HEADER" $TO_ADDR
fi

echo Running a sleep command so the mail can actually be send by the daemon
I=1
while [ "$(sendmail -bp)" != "Mail queue is empty" ]; do
  [[ $I == 10 ]] && echo Checked too many times, it just failed && exit 1
  echo checking for $I th time
  ((++I))
  sendmail -bp
  sleep 1
done
  
echo Mail send
exit 0
