#!/bin/sh -e

if [ -z "$1" ]; then
  echo "Please provide a file with user:PASSWORD_HASH, you can use; openssl passwd -apr1"
  exit
else
  USERSFILE="$1"
fi

DOCKERCOMPOSELOC=/tmp/webIDE/docker-compose.yml
mkdir -p "`dirname $DOCKERCOMPOSELOC`/users"


cat << 'EOF' > $DOCKERCOMPOSELOC
version: '3'
networks:
  webidenetwork: {}
services:
  firewall:
    image: svlentink/ipfilter
    links:
      - proxy
      - proxy:dontchangethisalias #creating a reference that we'll use
    ports:
      - 443:4321
    environment:
      APP_PORT: 80
#      ALLOWED_IPS: 10.0.0.0/8
    networks:
      - webidenetwork
  proxy:
    image: nginx:alpine
    volumes:
      - $PWD/nginx.conf:/etc/nginx/conf.d/default.conf:ro
      - $PWD/users:/users:ro
    networks:
      - webidenetwork
EOF

NGINXCONF="`dirname $DOCKERCOMPOSELOC`/nginx.conf"
cat << 'EOF' > $NGINXCONF
server {
  server_name _;
  location / {
    return 200 'please go to /YOUR_USERNAME';
    add_header Content-Type text/plain;
  }
  location ~ ^/(?<username>[a-z]+) {
    proxy_pass http://$username:8181;
    auth_basic "developer env";
    auth_basic_user_file /users/$username;
    rewrite ^/$username(/.*)$ $1 last;
  }
}
EOF

while read l; do
  USERNAME=`echo $l|sed "s/:.*//g"`
  echo "$l" > "`dirname $DOCKERCOMPOSELOC`/users/$USERNAME"
  cat << EOF >> $DOCKERCOMPOSELOC
  $USERNAME:
    networks:
      - webidenetwork
    volumes:
      - /home/$USERNAME:/workspace
    image: sapk/cloud9 # kdelfour/cloud9-docker
    command: ["--auth", ":"] #, "--listen", "0.0.0.0"]
EOF
done < $USERSFILE

cat << EOF
You can now run:
cd basename $DOCKERCOMPOSELOC
docker-compose up -d
EOF

