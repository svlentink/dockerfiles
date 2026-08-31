FROM docker.io/certbot/certbot
RUN apk add --no-cache openssl
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
