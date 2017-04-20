FROM certbot/certbot
COPY entry.sh /entryp
COPY auth.sh /auth.sh
RUN ln -s /auth.sh /cleanup.sh
ENTRYPOINT ["/entryp"]
