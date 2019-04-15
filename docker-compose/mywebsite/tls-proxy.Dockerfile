FROM svlentink/mywebsite
RUN rm /etc/nginx/conf.d/*.conf
COPY tls-proxy.conf /etc/nginx/conf.d/default.conf
