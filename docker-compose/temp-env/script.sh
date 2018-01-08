#!/bin/sh

if [ ! -f /etc/debian_version ]; then
  echo not a Debian based OS
  exit 1
fi

if [ -z "$(which docker)" ]; then
  echo installing docker
  curl -sSL https://get.docker.com/ | sh
  echo creating a user group for docker
  sudo usermod -aG docker $USER

  echo installing docker-compose
  # http://stackoverflow.com/questions/24987542/is-there-a-link-to-github-for-downloading-a-file-in-the-latest-release-of-a-repo
  GITHUB_REPO='docker/compose' \
  LATEST_RELEASE_TAG=$(curl -Is https://github.com/${GITHUB_REPO}/releases/latest \
                         | grep Location | grep -oE '[0-9]+\.[0-9]+\.[0-9]+') || true

  sudo curl -L \
    https://github.com/docker/compose/releases/download/$LATEST_RELEASE_TAG/docker-compose-`uname -s`-`uname -m` \
    -o /usr/local/bin/docker-compose
fi

read -p 'Please enter a username' username
echo MYUSER=$username >> /tmp/.env
read -p 'Please enter a passphrase' pass
echo PASSWD=$pass >> /tmp/.env

curl -so /tmp/docker-compose.yml \
  https://raw.githubusercontent.com/svlentink/dockerfiles/master/docker-compose/temp-env/docker-compose.yml

cd /tmp
docker-compose up -d

