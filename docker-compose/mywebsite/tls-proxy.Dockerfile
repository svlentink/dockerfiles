FROM svlentink/mywebsite
RUN rm /etc/nginx/conf.d/*.conf
COPY tls-proxy.conf /etc/nginx/conf.d/default.conf
RUN apk add --no-cache openssl
#CMD ["nginx", "-g", "daemon off;", "-with-openssl=/usr/bin/openssl"]
