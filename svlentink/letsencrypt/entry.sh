#!/bin/sh
set -e

if [ -z "$EMAIL" ]; then
  MAILSTR="--register-unsafely-without-email"
else
  MAILSTR="--email "$EMAIL
fi
echo using email options: $MAILSTR

# TODO when env. DEL is giving,
# it should revoke instead of ask for new cert.

# chain multiple domains, currently, if an apex is provide, is should be first
CERTNAME=$1

if [ ${#CERTNAME} -gt 64 ]; then
  echo Error: domain too long
  echo "this is explained at: https://github.com/certbot/certbot/issues/1915#issuecomment-165262834"
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
  --manual-auth-hook /auth.sh \
  --manual-cleanup-hook /cleanup.sh \
  --domains "$DOMAINS" \
  --cert-name "$CERTNAME" \
  --non-interactive \
  --agree-tos \
  --no-redirect \
  --webroot-path /tmp/challenge \
  $MAILSTR

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
