#!/bin/sh -e

if [ -z "$1" ]; then
  echo "Please provide a file with user:PASSWORD_HASH, you can use; openssl passwd -apr1"
  exit
else
  USERSFILE="$1"
fi

#which podman && docker=podman && echo Using podman instead of docker

DOCKERCOMPOSELOC=/tmp/webIDE/docker-compose.yml
mkdir -p "`dirname $DOCKERCOMPOSELOC`/"
cp $USERSFILE "`dirname $DOCKERCOMPOSELOC`/.htpasswd"

cat << 'EOF' > $DOCKERCOMPOSELOC
version: '3'
networks:
  webidenetwork: {}
services:
  firewall:
    image: svlentink/ipfilter
    links:
      - basic_auth
      - basic_auth:dontchangethisalias #creating a reference that we'll use
    ports:
      - 443:4321
    environment:
      APP_PORT: 80
#      ALLOWED_IPS: 10.0.0.0/8
    networks:
      - webidenetwork
  basic_auth:
    image: nginx:alpine
    volumes:
      - $PWD/nginx.conf:/etc/nginx/conf.d/default.conf:ro
      - $PWD/.htpasswd:/.htpasswd:ro
    networks:
      - webidenetwork
EOF

NGINXCONF="`dirname $DOCKERCOMPOSELOC`/nginx.conf"
cat << 'EOF' > $NGINXCONF
resolver 127.0.0.11;
server {
  server_name _;
  location / {
    proxy_pass http://$remote_user:8181;
    auth_basic "developer env";
    auth_basic_user_file /.htpasswd;
  }
}
EOF

while read l; do
  USERNAME=`echo $l|sed "s/:.*//g"`
  if [ -n "$USERNAME" ]; then
    cat << EOF >> $DOCKERCOMPOSELOC
  $USERNAME:
    networks:
      - webidenetwork
    volumes:
      - /home/$USERNAME:/workspace
    image: sapk/cloud9 # kdelfour/cloud9-docker
    command: ["--auth", ":"] #, "--listen", "0.0.0.0"]
EOF
  fi
done < $USERSFILE

cat << EOF
You can now run:
cd `dirname $DOCKERCOMPOSELOC`
docker-compose up -d
EOF

