#!/bin/bash -e

CIPHER=$1;shift

# If people do not mount a file, use sdin
[[ -n "$@" ]] && echo -e "$@" > /input.txt

node /ciphers/$CIPHER.js

