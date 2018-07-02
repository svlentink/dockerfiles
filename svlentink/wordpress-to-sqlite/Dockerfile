FROM tcgerlach/sqlite

RUN apk add --no-cache openssl; \
  wget -P /usr/local/bin https://raw.githubusercontent.com/dumblob/mysql2sqlite/master/mysql2sqlite; \
  chmod +x /usr/local/bin/mysql2sqlite;

COPY entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT /docker-entrypoint.sh

VOLUME /archive.zip
VOLUME /outp
