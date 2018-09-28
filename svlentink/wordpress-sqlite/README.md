# Wordpress + SQLite

This Wordpress container can be `run` as a stand alone container,
without the requirement of a separate DB.

```shell
docker run --rm -it -p 8080:80 svlentink/wordpress-sqlite
```

It has minimal a minimal installation and configuration,
see the `Dockerfile`.

## fpm

The tag `fpm` is a smaller, more efficient container.
Latest comes with apache, which is easier.

NOTE: for some reason, sqlite does not work with the fpm (which uses php-fpm).
Therefore, please use latest since I have no plan on fixing the fpm container
anytime soon, but feel free to submit a pull request.

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


## Wordpress removal issues

The wordpress entrypoint can delete your wordpress website,
as discussed [here](https://github.com/docker-library/wordpress/issues/84).

Just use `entrypoint: ["apache2-foreground"]`

