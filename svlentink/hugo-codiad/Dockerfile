FROM wernight/codiad
COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /code/workspace/hugo/public; \
  mkdir -p /etc/s6/hugo; \
  > /etc/s6/hugo/finish; \
  chmod +x /etc/s6/hugo/finish; \
  echo 'deb http://in.archive.ubuntu.com/ubuntu/ bionic main restricted universe multiverse' > /etc/apt/sources.list; \
  apt update; \
  apt install -y hugo; \
  apt-get clean; \
  rm -rf /var/lib/apt/lists/*
COPY hugo.sh /etc/s6/hugo/run

WORKDIR /code/workspace/hugo
VOLUME /code/workspace/hugo
