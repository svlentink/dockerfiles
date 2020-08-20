#!/bin/sh

CONFIG=/etc/nginx/conf.d/default.conf
FILTERCONF=/nginx-filter-options.conf
if [ -z "$COMMONNAME" ]; then
  COMMONNAME='www.lent.ink'
fi

if [ -z "$APP_PORT" ]; then
  echo Missing env variable APP_PORT
  exit 1
fi

cat << EOF > $CONFIG
upstream app_upstream {
  server dontchangethisalias:$APP_PORT;
}
EOF
cat << 'EOF' >> $CONFIG
upstream interim_upstream {
  server localhost;
}
map $http_upgrade $connection_upgrade {
  default upgrade;
  '' close;
}
server {
  listen 80;
  server_name _; #localhost
  include /nginx-filter-options.conf;
  location / {
    proxy_pass_request_headers on;
    proxy_pass http://app_upstream;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    # the following allow websockets
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $connection_upgrade;
  }
  error_page 401 /login.html;
  location = /login.html {
    root /var/nginx/login;
    auth_basic off;
    internal;
  }
}
server {
  listen 4321      ssl http2 default_server;
  listen [::]:4321 ssl http2 default_server;
  server_name _;

  ssl_certificate     /selfsigned.crt;
  ssl_certificate_key /selfsigned.key;
  ssl_dhparam         /dhparam.pem;
  
  ssl_protocols TLSv1.3;
  ssl_prefer_server_ciphers on;
  add_header X-Frame-Options SAMEORIGIN always;
  

  location / {
    set $auth $http_authorization;
    if ($cookie_basicauth) {
      set $auth "Basic $cookie_basicauth";
    }
    proxy_set_header Authorization $auth;
    proxy_pass http://interim_upstream;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    # the following allow websockets
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $connection_upgrade;
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
if [ -d /passdir ]; then
  if [ -f /passdir/.*passwd ]; then
    USING_BASIC_AUTH="yes"
    cp /passdir/.*passwd /.htpasswd
  fi
fi
if [ -n "$AUTH_PASS" ]; then
  USING_BASIC_AUTH="yes"
  if [ -z "$AUTH_USER" ]; then
    AUTH_USER=admin
  fi
  echo -n $AUTH_USER':' > /.htpasswd
  openssl passwd -apr1 "$AUTH_PASS" >> /.htpasswd
fi
if [ -n "$USING_BASIC_AUTH" ]; then
  echo Using basic auth
  echo 'auth_basic "closed site"; auth_basic_user_file /.htpasswd;' \
  >> $FILTERCONF
fi

if [ -z "$USING_BASIC_AUTH$ALLOWED_IPS" ]; then
  echo "No ALLOWED_IPS or basic auth config found."
  echo "Shutting down to prevent it from being open to the world."
  exit 1
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
  -subj "/C=NL/ST=NoordHolland/L=Amsterdam/O=Unknown/OU=Development/CN=$COMMONNAME"
  
  openssl dhparam \
  -out /dhparam.pem \
  1024
}

if ! [ -f /dhparam.pem ]; then
  genCert
  echo DONE generating cert.
fi

# https://github.com/nginxinc/docker-nginx/blob/1d2e2ccae2f6e478f628f4091d8a5c36a122a157/mainline/alpine/Dockerfile#L143
grep Alpine /etc/issue && nginx -g "daemon off;"
# we check if we are inside a docker container by checking if it's alpine linux
