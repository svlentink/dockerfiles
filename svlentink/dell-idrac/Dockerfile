FROM debian:jessie
ENV DEBIAN_FRONTEND noninteractive

# https://mozilla.debian.net/
RUN echo deb http://mozilla.debian.net/ jessie-backports firefox-release \
  >> /etc/apt/sources.list.d/firefox.list

RUN apt update && apt install -y --force-yes \
  -t jessie-backports firefox \
  icedtea-7-plugin \
  curl \
  libxext-dev libxrender-dev libxtst-dev \
  wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/firefox"]
