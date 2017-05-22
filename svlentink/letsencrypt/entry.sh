#!/bin/sh
set -e

if [ -z "$EMAIL" ]; then
  MAILSTR="--register-unsafely-without-email"
else
  MAILSTR="--email "$EMAIL
fi
echo using email options: $MAILSTR

# Note, whe have implemented revoking as a separate service!

# chain multiple domains, currently, if an apex is provide, is should be first
CERTNAME=$1

if [ ${#CERTNAME} -gt 64 ]; then
  echo Error: domain too long
  echo "this is explained at: https://github.com/certbot/certbot/issues/1915#issuecomment-165262834"
  echo you can fix this by adding a shorter domain as the first one
  exit 1
fi

I=0
for dom in "$@"; do
  DOMAINS=$DOMAINS$dom
  I=$((I+1))
  [ "$I" -lt "$#" ] && DOMAINS=$DOMAINS","
done
echo domains found: $DOMAINS

BASE_PATH=/etc/letsencrypt/live/$CERTNAME
CERT_PATH=$BASE_PATH/cert.pem   # public key
KEY_PATH=$BASE_PATH/privkey.pem # private key
CHAIN_PATH=$BASE_PATH/chain.pem

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
#  --webroot-path /tmp/challenge \

jsonLines () {
  local InpFile=$1
  local result="["
  while read line; do
    result=$result'"'$line'",'
  done <$InpFile
  result=${result%?}"]"
  echo $result
}

echo "### BEGIN JSON ###"
echo '{cert:'$(jsonLines $CERT_PATH)',key:'$(jsonLines $KEY_PATH)',chain:'$(jsonLines $CHAIN_PATH)'}'

exit 0
