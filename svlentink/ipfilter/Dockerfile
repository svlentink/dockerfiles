FROM nginx:alpine
RUN apk add --no-cache openssl; \
    mkdir -p /var/nginx/login;
COPY login.html /var/nginx/login/
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
