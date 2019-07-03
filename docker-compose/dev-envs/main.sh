#!/bin/sh

if [ -z "$1" ]; then
  echo "Please provide a file with user:PASSWORD_HASH, you can use; openssl passwd -apr1"
  exit
else
  USERSFILE="$1"
fi

DOCKERCOMPOSELOC=/tmp/webIDE/docker-compose.yml
mkdir -p "`basename $DOCKERCOMPOSELOC`/users"


cat << 'EOF' > $DOCKERCOMPOSELOC
version: '3'
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
      ALLOWED_IPS: 10.0.0.0/8

  proxy:
    image: nginx:alpine
    volumes:
      - $PWD/nginx.conf:/etc/nginx/nginx.conf:ro
      - $PWD/users:/users:ro

EOF

NGINXCONF="`basename $DOCKERCOMPOSELOC`/nginx.conf"
cat << 'EOF' > $NGINXCONF
server {
  location / {
    return 200 'please go to /YOUR_USERNAME';
    add_header Content-Type text/plain;
  }
  location ~ ^/(?<username>[a-z]+) {
    proxy_pass http://$username;
    auth_basic "developer env";
    auth_basic_user_file /users/$username
  }
}
EOF

while read l; do
  USERNAME=`echo $l|sed "s/:.*//g"`
  echo "$l" > "`basename $DOCKERCOMPOSELOC`/users/$USERNAME"
  cat << EOF >> $DOCKERCOMPOSELOC
  $USERNAME:
    volumes:
      - /home/$USERNAME:/workspace
    image: sapk/cloud9
    command: ["--auth", ":"]
EOF
done < $USERSFILE

cat << EOF
You can now run:
cd basename $DOCKERCOMPOSELOC
docker-compose up -d
EOF

