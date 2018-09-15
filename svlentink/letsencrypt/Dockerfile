FROM certbot/certbot
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY test-entrypoint.sh /test-entrypoint
COPY auth.sh /auth
RUN ln -s /auth /cleanup
ENTRYPOINT ["/docker-entrypoint.sh"]
