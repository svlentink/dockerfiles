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
But latest comes with apache, which is easier.

## Wordpress removal issues

The wordpress entrypoint can delete your wordpress website,
as discussed [here](https://github.com/docker-library/wordpress/issues/84).

Just use `entrypoint: ["apache2-foreground"]`

