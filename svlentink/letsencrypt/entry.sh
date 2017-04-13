#!/bin/sh
set -e

if [ -z "$EMAIL" ]; then
  MAILSTR="--register-unsafely-without-email"
else
  MAILSTR="--email "$EMAIL
fi

# TODO when env. DEL is giving,
# it should revoke instead of ask for new cert.

# chain multiple domains
CERTNAME=$1
I=0
for dom in "$@"; do
  DOMAINS=$DOMAINS$dom
  I=$((I+1))
  [ "$I" -lt "$#" ] && DOMAINS=$DOMAINS","
done

CERT_PATH=/$CERTNAME/cert # public key
KEY_PATH=/$CERTNAME/key   # private key
CHAIN_PATH=/$CERTNAME/chain

# https://github.com/certbot/certbot/blob/master/Dockerfile
certbot certonly \
  --cert-name "$CERTNAME" \
  --preferred-challenges=http \
  --domains "$DOMAINS" \
  --non-interactive \
  --force-renewal \
  --agree-tos \
  --quiet \
  --no-redirect \
  --cert-path "$CERT_PATH" \
  --key-path "$KEY_PATH" \
  --chain-path "$CHAIN_PATH" \
  $MAILSTR
