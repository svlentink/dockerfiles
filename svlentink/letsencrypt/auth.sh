#!/bin/sh
CHALLENGEPATH=/tmp/challenge/.well-known/acme-challenge
mkdir -p $CHALLENGEPATH
echo $CERTBOT_VALIDATION > $CHALLENGEPATH/$CERTBOT_TOKEN
