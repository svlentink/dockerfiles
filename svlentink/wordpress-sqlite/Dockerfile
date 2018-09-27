FROM wordpress
  
# wordpress.org/plugins/sqlite-integration/#installation
ENV PLUGIN_VERSION 1.8.1
RUN curl -o /sqlite-plugin.zip \
      https://downloads.wordpress.org/plugin/sqlite-integration.${PLUGIN_VERSION}.zip; \
    apt update; \
    apt install -y unzip; \
    apt clean; \
    rm -rf /var/lib/apt/lists/*; \
    unzip /sqlite-plugin.zip \
      -d /usr/src/wordpress/wp-content/plugins/; \
    rm /sqlite-plugin.zip; \
    cp /usr/src/wordpress/wp-content/plugins/sqlite-integration/db.php /usr/src/wordpress/wp-content; \
    chown -R www-data:www-data /var/www
