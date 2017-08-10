#!/bin/bash -e

OPENSSL_REQ_FILE_LOC=/openssl.conf
KEY_FILE_LOC=/pubkey.pem
CSR_FILE_LOC=/csr.pem

function createReqFile {
  echo Entering $FUNCNAME with $@
  local Fqdns=$@
  [[ -z "$Fqdns" ]] \
    && echo No domains provide \
    && exit 1
  ( [[ -z "$COUNTRY_CODE" ]] \
    || ( [[ -z "$PROVINCE" ]] && [[ -z "$STATE" ]] ) \
    || [[ -z "$CITY" ]] ) \
    && echo Location info missing \
    && exit 1
  [[ -z "ORGANIZATION" ]] \
    && echo Organization name missing \
    && exit 1
  [[ -z "$COMMONNAME" ]] \
    && echo No commonname found, using $1 \
    && local COMMONNAME=$1

cat << EOF > $OPENSSL_REQ_FILE_LOC
# openssl req -config this_config_file.cnf -new -out csr.pem
[ req ]
default_bit        = 2048
default_md         = sha512
default_keyfile    = $KEY_FILE_LOC
prompt             = no
encrypt_key        = no
distinguished_name = req_distinguished_name # base request
req_extensions     = v3_req

[ req_distinguished_name ] # distinguished_name
# https://wiki.openssl.org/index.php/Manual:Req(1)#DISTINGUISHED_NAME_AND_ATTRIBUTE_SECTION_FORMAT
countryName            = "$COUNTRY_CODE"   # C=
stateOrProvinceName    = "$STATE$PROVINCE" # ST=
localityName           = "$CITY"           # L=
organizationName       = "$ORGANIZATION"   # O=
organizationalUnitName = "Operations"      # OU=
commonName             = "$C" # CN=

[ v3_req ] # req_extensions
# https://www.openssl.org/docs/manmaster/man5/x509v3_config.html
EOF

  for fqdn in $Fqdns; do
    echo "subjectAltName = DNS:"$fqdn >> $OPENSSL_REQ_FILE_LOC
  done
}

if [[ ! -f $OPENSSL_REQ_FILE_LOC ]]; then
  echo Composing $OPENSSL_REQ_FILE_LOC
  createReqFile $@
fi

openssl req -config $OPENSSL_REQ_FILE_LOC -new -out $CSR_FILE_LOC
