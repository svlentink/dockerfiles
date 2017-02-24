FROM ubuntu
ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt install -y --force-yes \
  firefox \
  icedtea-plugin \
  curl \
  libxext-dev libxrender-dev libxtst-dev xvfb \
  wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# http://stackoverflow.com/questions/24653127/selenium-error-no-display-specified
CMD /bin/bash -c 'Xvfb & sleep 1 && firefox'
