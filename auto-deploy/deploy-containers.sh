#!/bin/sh

update_container() {
  IMAGE=$1
  COMPOSEPATH=$2 # path to docker-compose file
  SERVICEINCOMPOSE=$3 # name of service inside the docker-compose file
  
  status="`docker pull $IMAGE|grep 'Status:'`"
  echo $status|grep -q 'up to date' && return
  echo $status|grep -q 'newer image'; \
    cd $COMPOSEPATH; \
    docker-compose pull $SERVICEINCOMPOSE; \
    docker-compose stop $SERVICEINCOMPOSE; \
    docker-compose rm -vf $SERVICEINCOMPOSE; \
    docker-compose up -d $SERVICEINCOMPOSE;
}

update_container \
  svlentink/mywebsite \
  '/root/Dropbox/webIDE/dockerfiles/docker-compose/mywebsite' \
  cdn

