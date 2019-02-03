#!/bin/sh

CONFIG=/etc/nginx/conf.d/default.conf
FILTERCONF=/nginx-filter-options.conf

if [ -z "$APP_PORT" ]; then
  echo Missing env variable APP_PORT
  exit 1
fi

if [ -d /passdir ]; then
  echo 'You are using the old container format, please check'
  echo 'hub.docker.com/r/svlentink/ipfilter'
  exit
fi

cat << EOF > $CONFIG
upstream app_upstream {
  server dontchangethisalias:$APP_PORT;
}
server {
  listen 4321      ssl http2 default_server;
  listen [::]:4321 ssl http2 default_server;
  server_name _;

  ssl_certificate     /selfsigned.crt;
  ssl_certificate_key /selfsigned.key;
  ssl_dhparam         /dhparam.pem;
  
  ssl_protocols TLSv1.2;
  add_header X-Frame-Options DENY;
  
  include /nginx-filter-options.conf;

  location / {
    proxy_pass http://app_upstream;
    proxy_set_header Host \$host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto \$scheme;
  }
}

EOF

> $FILTERCONF
if [ -n "$ALLOWED_IPS" ];then
  echo ALLOWED_IPS is set
  for iprange in $ALLOWED_IPS; do
    echo "allow $iprange;" >> $FILTERCONF
  done
  echo "deny all;" >> $FILTERCONF
fi
if [ -n "$AUTH_PASS" ]; then
  echo Using basic auth
  echo 'auth_basic "closed site"; auth_basic_user_file /.htpasswd;' \
  >> $FILTERCONF
  if [ -n "$AUTH_USER" ]; then
    export AUTH_PASS=admin
  fi
  echo -n $AUTH_USER':' > /.htpasswd
  openssl passwd -apr1 "$AUTH_PASS" >> /.htpasswd
fi

echo BEGIN content of nginx filter
cat /nginx-filter-options.conf
echo END content of nginx filter

genCert () {
  openssl req -x509 \
  -nodes \
  -days 365 \
  -newkey rsa:2048 \
  -keyout /selfsigned.key \
  -out /selfsigned.crt \
  -batch \
  -subj "/C=NL/ST=NoordHolland/L=Amsterdam/O=Unknown/OU=Development/CN=www.lent.ink"
  
  openssl dhparam \
  -out /dhparam.pem \
  1024
}

if ! [ -f /dhparam.pem ]; then
  genCert
  echo DONE generating cert.
fi

# https://github.com/nginxinc/docker-nginx/blob/1d2e2ccae2f6e478f628f4091d8a5c36a122a157/mainline/alpine/Dockerfile#L143
nginx -g "daemon off;"
