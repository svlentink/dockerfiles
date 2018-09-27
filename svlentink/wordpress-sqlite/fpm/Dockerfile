FROM wordpress:fpm-alpine

ENV PLUGIN_VERSION 1.8.1
RUN set -e; \
  wget -O /sqlite-plugin.zip \
    https://downloads.wordpress.org/plugin/sqlite-integration.${PLUGIN_VERSION}.zip; \
  unzip /sqlite-plugin.zip \
    -d /usr/src/wordpress/wp-content/plugins/; \
    rm /sqlite-plugin.zip; \
    cp /usr/src/wordpress/wp-content/plugins/sqlite-integration/db.php /usr/src/wordpress/wp-content; \
    chown -R www-data:www-data /var/www
