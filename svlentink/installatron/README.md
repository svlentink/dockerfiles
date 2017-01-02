# Installatron Base image

[docker hub](https://hub.docker.com/r/svlentink/installatron/)

Use this image to create your own.
The installation process takes a while,
you can shorten this by using this base image.

Your container should look something like:
```bash
FROM svlentink/installatron

RUN service mysql start
RUN ./installatron-server.sh -f --key NOW_WE_DO_RUN_IT_WITH_A_VALID_KEY
WORKDIR /usr/local/installatron/
CMD service mysql start && nginx -g 'daemon off;'
EXPOSE 443
EXPOSE 8080
EXPOSE 80

```

For more info, [see the docs](http://installatron.com/developer/server#2.3)

```bash
# service --status-all minus the services that are allready in the debian:8 docker
 [ - ]  cron
 [ - ]  exim4
 [ + ]  mysql
 [ + ]  nginx
 [ - ]  varnish
 [ - ]  varnishlog
 [ - ]  varnishncsa
```
