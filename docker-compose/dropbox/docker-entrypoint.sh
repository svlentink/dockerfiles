#!/bin/sh

dropboxd
sleep 10
dropbox-cli status
sleep 10

cd /root/Dropbox

while true
do
  (dropbox-cli filestatus || echo ERROR dropbox not running) | grep -v 'up to date' | grep -v '\.dropbox'
  sleep 36000 # very 10h
done
