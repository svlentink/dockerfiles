#!/bin/sh

if [ -f /archive.zip ]; then
  echo 'Using /archive.zip'
else
  echo 'Please generate an *archive.zip using https://wordpress.org/plugins/duplicator/'
  exit 1
fi
if [ -f /outp/index.php ]; then
  echo '/outp already an index.php, stopping before we may overwrite'
  exit 1
fi

echo '=== unzipping /archive.zip'
ZIPC=/tmp/zipcontent
rm -rf $ZIPC
mkdir -p $ZIPC
cd $ZIPC
unzip -q /archive.zip

if [ ! -f $ZIPC/.htaccess ]; then
# http://www.digitesters.com/linux-include-hidden-files-in-tar-archive/
  echo "WARNING No .htaccess found in your archive.zip"
  echo "The following excludes hidden files: tar cvfz archive.tgz /some/path/*"
  echo "while using a '.' instead of a '*' will include hidden files."
fi

echo '=== Converting database.sql from archive'
DBLOC=wp-content/database
mkdir -p $ZIPC/$DBLOC
# https://github.com/dumblob/mysql2sqlite
mysql2sqlite $ZIPC/database.sql | sqlite3 $ZIPC/$DBLOC/.ht.sqlite

echo '=== downloading sqlite plugin wordpress'
# wordpress.org/plugins/sqlite-integration/#installation
PLUGIN_VERSION=1.8.1
wget -qO /sqlite-plugin.zip \
  https://downloads.wordpress.org/plugin/sqlite-integration.${PLUGIN_VERSION}.zip
unzip -qn /sqlite-plugin.zip \
  -d $ZIPC/wp-content/plugins/
cp $ZIPC/wp-content/plugins/sqlite-integration/db.php $ZIPC/wp-content

echo '=== moving to output'
mv $ZIPC/* /outp/
echo "=== The output dir can be mounted in wordpress at /var/www/html"
echo "=== example: docker run -it --rm -v \$PWD/html:/var/www/html -p 80:80 wordpress"
echo "=== You may want to add the following two to wp-config.php:"
echo "define('WP_HOME','http://example.com:8080/');"
echo "define('WP_SITEURL','http://127.0.0.1:80/');"
