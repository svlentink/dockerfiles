FROM alpine

# No needed anymore: --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
RUN apk --no-cache \
  add exim; \
  ln -s /dev/stdout /var/log/exim/mainlog; \
  ln -s /dev/stderr /var/log/exim/paniclog; \
  ln -s /dev/stderr /var/log/exim/rejectlog; \
  mkdir -p /etc/exim/conf.d; \
  mv /etc/exim/exim.conf /etc/exim/conf.d/default.conf; \
  echo ".include_if_exists /etc/exim/conf.d/*.conf" > /etc/exim/exim.conf;

EXPOSE 25
VOLUME ["/etc/exim/conf.d"]

ENTRYPOINT ["/usr/sbin/exim"]
CMD ["-bdf", "-q15m"]
