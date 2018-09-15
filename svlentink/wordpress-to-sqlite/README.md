# Convert wordpress with mysql to sqlite

First download an `archive.zip` from your Wordpress admin interface,
which can be created with [duplicator](https://wordpress.org/plugins/duplicator/).

Now run the [docker-compose.yml](https://github.com/svlentink/dockerfiles/blob/master/svlentink/wordpress-to-sqlite/docker-compose.yml),
which will end with instructions to run it in a docker container,
or you can used a regular PHP enabled hoster.

## Simple config file

The bare minimum:
```
$ cat /var/www/html/wp-config.php 
<?php $table_prefix = 'wp_';
$_SERVER['HTTPS'] = 'on';
define('WP_HOME','https://lent.ink');
define('WP_SITEURL','https://lent.ink');
require_once(ABSPATH . 'wp-settings.php');

```

