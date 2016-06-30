# docker build -f Dockerfile -t superbuddy/backofficebase .
FROM php:5-fpm

MAINTAINER svlentink <sander@superbuddy.nl>
LABEL Description="base image for superbuddy backoffice" \
  Version="0.1"

# https://github.com/phusion/baseimage-docker/issues/58
# http://serverfault.com/questions/618994/when-building-from-dockerfile-debian-ubuntu-package-install-debconf-noninteract
ENV DEBIAN_FRONTEND noninteractive

# runs during installation and remove junk, as described in http://docs.docker.com/engine/articles/dockerfile_best-practices/#apt-get
RUN apt-get update && \
  apt-get install -y \
#  redis-server \
  nginx \
  mcrypt \
# ubuntu = php-mcrypt, debian = php5-mcrypt
  php5-mcrypt \
  php5-fpm \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Composer; https://github.com/revollat/docker-nginx-php-composer/blob/master/Dockerfile
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN php5enmod mcrypt
# RUN service php-fpm restart && echo 'not needed, since the docker container is just build'