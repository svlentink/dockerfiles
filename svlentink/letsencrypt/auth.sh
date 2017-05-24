#!/bin/sh
# Certbot only shows stderr from this script
echo 'Entering $0 CERTBOT_VALIDATION=$CERTBOT_VALIDATION CERTBOT_TOKEN=$CERTBOT_TOKEN $@' 1>&2
CHALLENGEPATH=/tmp/challenge/.well-known/acme-challenge
mkdir -p $CHALLENGEPATH
echo $CERTBOT_VALIDATION > $CHALLENGEPATH/$CERTBOT_TOKEN
