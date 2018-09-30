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

## Warning
Please use this as an example environment,
sqlite is not a good idea for production,
had too much issues with it.

Try something like this (it did not work for me):
```shell
apt install -y sqlite3 sqlfairy libdbd-sqlite3-perl
sqlite3 .ht.sqlite .dump > sqlite.dump
sqlt --from DBI --dsn dbi:SQLite:./MYsqlite.db --to MySQL > dump.sql
sed -e 's/text NOT NULL DEFAULT/text NOT NULL, --/g' -i dump.sql
sqlt --from SQLite --to MySQL .ht.sqlite > dump.sql
```
