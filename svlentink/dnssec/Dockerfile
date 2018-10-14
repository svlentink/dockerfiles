FROM python:alpine
RUN apk add --no-cache bind bind-tools; \
  mkdir -p /keys /generated /zonefiles; \
  touch /zonefiles/example.com.zone
EXPOSE 53
EXPOSE 53/udp

COPY gen_dnssec.py /
COPY auth.conf /etc/named.conf

ENV GENERATED_FILES_DIR /generated
ENV SERVERTYPE master
VOLUME /zonefiles
VOLUME /keys
ENTRYPOINT ["sh","-c"]
CMD ["/gen_dnssec.py; named-checkconf $GENERATED_FILES_DIR/named.conf; named -f -c $GENERATED_FILES_DIR/named.conf"]
