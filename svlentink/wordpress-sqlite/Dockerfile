FROM wordpress
  
# wordpress.org/plugins/sqlite-integration/#installation
ENV PLUGIN_VERSION 1.8.1
RUN curl -o /sqlite-plugin.zip \
      https://downloads.wordpress.org/plugin/sqlite-integration.${PLUGIN_VERSION}.zip; \
    apt update; \
    apt install -y unzip; \
    apt clean; \
    rm -rf /var/lib/apt/lists/*; \
#    mkdir -p /usr/src/wordpress/wp-content/plugins; \
    unzip /sqlite-plugin.zip \
      -d /usr/src/wordpress/wp-content/plugins/; \
    rm /sqlite-plugin.zip; \
#    ln -s /usr/src/wordpress/wp-content/plugins/sqlite-integration/db.php /usr/src/wordpress/wp-content;
    cp    /usr/src/wordpress/wp-content/plugins/sqlite-integration/db.php /usr/src/wordpress/wp-content;
#    RANDOM=$(echo `date && hostname` | sha1sum) \
#    && sed -i 's/put your unique phrase here/$RANDOM/g' /var/www/wp-config.php

#RUN curl -o /var/www/wp-config.php https://raw.githubusercontent.com/milanboers/wordpress-sqlite/master/config/wp-config.php
#RUN curl https://raw.githubusercontent.com/milanboers/wordpress-sqlite/master/config/wp-config.php|head -34 > /var/www/wp-config.php
RUN echo "<?php \$table_prefix = 'wp_'; require_once(ABSPATH . 'wp-settings.php');" \
  > /var/www/wp-config.php
RUN chown -R www-data:www-data /var/www











