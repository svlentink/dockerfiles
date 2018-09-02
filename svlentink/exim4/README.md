# Exim4 on Alpine

This image has no exim user (libcap) since we do not expect to write to disk.
The logs are linked to std[out|err] to enable `docker logs IMAGE_NAME`.
The default config is located at `/etc/exim/exim.conf` which you can overwrite with your own by mounting a file at this location.
You can find the default config [here](https://raw.githubusercontent.com/Exim/exim/master/src/src/configure.default).
You can also mount `/etc/exim/conf.d/`

## Based on
+ https://hub.docker.com/r/primesign/exim4/~/dockerfile/
+ https://hub.docker.com/r/biig/docker-exim-relay/~/dockerfile/
+ https://hub.docker.com/r/industrieco/exim-relay/~/dockerfile/
+ https://hub.docker.com/r/selim13/exim-relay/~/dockerfile/

## TODO

https://www.exim.org/exim-html-current/doc/html/spec_html/ch-the_default_configuration_file.html
https://github.com/biig-io/docker-exim-relay/tree/master/conf.d
https://github.com/primesign/docker-exim4
