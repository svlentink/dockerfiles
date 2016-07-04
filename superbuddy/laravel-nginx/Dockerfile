# docker build -f Dockerfile -t superbuddy/laravel-nginx .
FROM php:5-fpm

MAINTAINER svlentink <sander@superbuddy.nl>
LABEL Description="Laravel and Nginx"

# https://github.com/phusion/baseimage-docker/issues/58
# http://serverfault.com/questions/618994/when-building-from-dockerfile-debian-ubuntu-package-install-debconf-noninteract
ENV DEBIAN_FRONTEND noninteractive

# runs during installation and remove junk, as described in http://docs.docker.com/engine/articles/dockerfile_best-practices/#apt-get
RUN apt-get update && \
  apt-get install -y \
  nginx \
# https://github.com/docker-library/php/issues/60
  zlib1g-dev \
  mcrypt \
# ubuntu = php-mcrypt, debian = php5-mcrypt
  php5-mcrypt \
  php5-fpm \
# http://serverfault.com/questions/436634/installing-php-extensions-on-linux
  php5-gd \
  php5-mysql \
  php5-curl \
  && apt-get clean && rm -rf /var/lib/apt/lists/* \
# https://hub.docker.com/r/ganiutomo/docker-php-laravel/~/dockerfile/
  && docker-php-ext-install zip

# Install composer (PHP dep. manager)
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN php5enmod mcrypt

COPY nginx.conf /etc/nginx/sites-available/default
RUN sed -i "s/cgi.fix_pathinfo=/cgi.fix_pathinfo=0#/g" /etc/php5/fpm/php.ini
