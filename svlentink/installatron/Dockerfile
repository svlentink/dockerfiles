FROM debian:8

ENV DEBIAN_FRONTEND noninteractive
# http://installatron.com/developer/server#2.3
RUN apt-get update && \
  apt-get -y install curl
RUN curl -O https://data.installatron.com/installatron-server.sh
RUN chmod +x installatron-server.sh
RUN ./installatron-server.sh -f --key YOUR_LICENSE_KEY

# the top commands are fixed, so docker uses its caching layers
# we run it now again, with a valid key, so we use the cached installed packages
# and do not reinstall everything when a key is changed
# So the following lines should be in your docker image,
# which uses this image as a base image.

# RUN ./installatron-server.sh -f --key NOW_WE_DO_RUN_IT_WITH_A_VALID_KEY
# WORKDIR /usr/local/installatron/
