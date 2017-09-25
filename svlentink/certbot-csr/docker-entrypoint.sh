#!/bin/sh -e

OUTPUT_LOC=/outputdir
OPENSSL_REQ_FILE_LOC=/openssl.conf
KEY_FILE_LOC=$OUTPUT_LOC/key.pem
CSR_FILE_LOC=$OUTPUT_LOC/csr.pem

createReqFile () {
  echo Entering $FUNCNAME with $@
  local Fqdns=$@
  if [ -z "$Fqdns" ]; then
    echo No domains provide
    exit 1
  fi
  if ( [ -z "$COUNTRY_CODE" ] \
    || ( [ -z "$PROVINCE" ] && [ -z "$STATE" ] ) \
    || [ -z "$CITY" ] ); then
    echo Location info missing
    exit 1
  fi
  if [ -z "ORGANIZATION" ]; then
    echo Organization name missing
    exit 1
  fi
  if [ -z "$COMMONNAME" ]; then
    echo No commonname found, using $1
    local COMMONNAME=$1
  fi

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
commonName             = "$COMMONNAME" # CN=

[ v3_req ] # req_extensions
# https://www.openssl.org/docs/manmaster/man5/x509v3_config.html
EOF

  for fqdn in $Fqdns; do
    echo "subjectAltName = DNS:"$fqdn >> $OPENSSL_REQ_FILE_LOC
  done
}

if [ ! -f $OPENSSL_REQ_FILE_LOC ]; then
  echo Composing $OPENSSL_REQ_FILE_LOC
  createReqFile $@
else
  echo Using the existing config found at $OPENSSL_REQ_FILE_LOC
fi

openssl req -config $OPENSSL_REQ_FILE_LOC -new -out $CSR_FILE_LOC
openssl req -text -noout -in $CSR_FILE_LOC | head
