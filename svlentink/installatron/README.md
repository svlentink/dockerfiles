# Installatron Base image

Use this image to create your own.
The installation process takes a while,
you can shorten this by using this base image.

Your container should look something like:
```bash
FROM svlentink/installatron

RUN ./installatron-server.sh -f --key NOW_WE_DO_RUN_IT_WITH_A_VALID_KEY
WORKDIR /usr/local/installatron/
COPY nginx.conf /etc/nginx/nginx.conf
CMD service mysql start && php5-fpm -R && nginx -g 'daemon off;'
EXPOSE 443
EXPOSE 8080

```
For more info, [see the docs](http://installatron.com/developer/server#2.3)

