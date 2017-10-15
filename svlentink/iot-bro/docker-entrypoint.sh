#!/bin/sh

bro -r /input #test-all-policy

# since the script we use from github does not include all field types, we just change some
for log in *.log
do
  sed -i 's/vector\[string/set\[string/g' $log
  sed -i 's/vector\[interval\]/string/g' $log
#  sed -i 's/vector\[/set\[/g' $log
done

/main.py
