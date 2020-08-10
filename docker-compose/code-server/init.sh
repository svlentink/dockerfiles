#!/bin/sh

echo Creating key for webide to access host
mkdir -p sshkey

cat << EOF > sshkey/login-to-host.sh
#!/bin/sh
ssh -i /sshkey/id_pub root@172.17.0.1
EOF

chmod +x sshkey/login-to-host.sh

ssh-keygen -N '' -f sshkey/id_rsa
cat sshkey/id_rsa.pub >> /root/.ssh/authorized_keys

if [ ! -f passdir/.*passwd ]; then
  read -p "Please provide username:" USERNAME
  read -p "Pleas provide password:" PASSWORD
  echo -n "$USERNAME:" > passdir/.htpasswd
  openssl passwd -apr1" "$PASSWORD" >> passdir/.htpasswd
fi


