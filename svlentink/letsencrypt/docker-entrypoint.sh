#!/bin/sh
set -e

OUTPUTDIR=/pemfiles

if [ -z "$EMAIL" ]; then
  MAILSTR="--register-unsafely-without-email"
else
  MAILSTR="--email "$EMAIL
fi
echo using email options: $MAILSTR

if [ -z "$OUTPUTDIRNAME" ]; then
  # chain multiple domains, currently, if an apex is provide, is should be first
  CERTNAME=$1
else
  CERTNAME=$OUTPUTDIRNAME
fi

if [ ${#CERTNAME} -gt 64 ]; then
  echo "Error: cert-name too long"
  echo "this is explained at: https://github.com/certbot/certbot/issues/1915#issuecomment-165262834"
  echo you can fix this by adding a shorter domain as the first one or setting env COMMONNAME
  exit 1
fi

I=0
for dom in "$@"; do
  DOMAINS=$DOMAINS$dom
  I=$((I+1))
  [ "$I" -lt "$#" ] && DOMAINS=$DOMAINS","
done
echo domains found: $DOMAINS

# https://github.com/certbot/certbot/blob/master/Dockerfile
certbot certonly --manual \
  --preferred-challenges=http \
  --manual-public-ip-logging-ok \
  --manual-auth-hook /auth \
  --manual-cleanup-hook /cleanup \
  --domains "$DOMAINS" \
  --cert-name "$CERTNAME" \
  --non-interactive \
  --agree-tos \
  --no-redirect \
  $MAILSTR

cp  /etc/letsencrypt/archive/*/*.pem $OUTPUTDIR/
echo Copied the .pem files in $OUTPUTDIR

exit 0

