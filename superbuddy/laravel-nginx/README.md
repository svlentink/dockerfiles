# laravel-nginx

Just Laravel, Nginx, PHP fpm and Mcrypt.
We put this online, since we could not find a decent base image for our use.

## Our usage
The previous version of the Superbuddy backoffice uses some libraries on top of composer (PHP).
This Docker image contains the base on which the backoffice is build.
The next Docker image uses `FROM superbuddy/laravel-nginx` and specifies the ENVironment variables,
PORTS and ENTRYPOINT.