FROM alpine


RUN apk --no-cache \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  add exim; \
  ln -s /dev/stdout /var/log/exim/main; \
  ln -s /dev/stderr /var/log/exim/panic; \
  ln -s /dev/stderr /var/log/exim/reject; \
  mkdir -p /etc/exim/conf.d; \
  mv /etc/exim/exim.conf /etc/exim/conf.d/default.conf; \
  echo ".include_if_exists /etc/exim/conf.d/*.conf" > /etc/exim/exim.conf;

EXPOSE 25
VOLUME ["/etc/exim/conf.d"]

ENTRYPOINT ["/usr/sbin/exim"]
CMD ["-bdf", "-q15m"]
