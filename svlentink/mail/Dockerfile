FROM debian
ENV DEBIAN_FRONTEND noninteractive

# Telnet to; 'telnet smtp.example.com 25'
# Netcat; 'nc -zv -w1 smtp.example.com 25'
RUN apt-get update \
  && apt-get install --assume-yes -y \
  postfix \
  mailutils \
  netcat \
  telnet \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY main.cf /etc/postfix/main.cf
RUN ln -s etc/resolv.conf /var/spool/postfix/etc/resolv.conf
RUN /etc/init.d/postfix reload

COPY entrypoint.sh /usr/local/bin/entrypoint
# https://github.com/docker/docker/issues/1149
ENTRYPOINT ["/usr/local/bin/entrypoint"]
