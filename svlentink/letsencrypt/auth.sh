#!/bin/sh
#                                             Certbot only shows stderr from this script
echo "Entering $0 with $@"                    1>&2
echo "CERTBOT_VALIDATION=$CERTBOT_VALIDATION" 1>&2
echo "CERTBOT_TOKEN=$CERTBOT_TOKEN"           1>&2
echo "CERTBOT_DOMAIN=$CERTBOT_DOMAIN"         1>&2

CHALLENGEPATH=/tmp/challenge/.well-known/acme-challenge
mkdir -p $CHALLENGEPATH
echo $CERTBOT_VALIDATION > $CHALLENGEPATH/$CERTBOT_TOKEN
