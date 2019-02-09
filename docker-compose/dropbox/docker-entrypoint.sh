#!/bin/sh

dropboxd
sleep 10
dropbox-cli status
sleep 10

cd /root/Dropbox

while true
do
  dropbox-cli filestatus || echo ERROR dropbox not running
  sleep 36000 # very 10h
done
