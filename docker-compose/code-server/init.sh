#!/bin/sh

echo Creating key for webide to access host
mkdir -p sshkey
ssh-keygen -N '' -f sshkey/id_rsa
mkdir -p /root/.ssh
cat sshkey/id_rsa.pub >> /root/.ssh/authorized_keys

if [ ! -f passdir/.*passwd ]; then
  read -p "Please provide username:" USERNAME
  read -p "Pleas provide password:" PASSWORD
  echo -n "$USERNAME:" > passdir/.htpasswd
  openssl passwd -apr1 "$PASSWORD" >> passdir/.htpasswd
fi

if which scw-metadata; then
  CN=`scw-metadata PUBLIC_IP_ADDRESS`
else
  read -p "Please provide the public IP address or hostname to use for the commonname:" CN
fi
echo "COMMONNAME=$CN" > .env
