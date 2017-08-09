FROM certbot/certbot
RUN apk add --no-cache openssl
COPY docker-entrypoint.sh /
COPY openssl-req.conf
ENTRYPOINT ["/entryp"]
