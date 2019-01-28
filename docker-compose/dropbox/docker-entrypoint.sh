#!/bin/sh
dropboxd
sleep 10
dropbox-cli status
sleep 10
cd /root/Dropbox

while true
do
  dropbox-cli filestatus || echo ERROR dropbox not running
  sleep 3600
done

