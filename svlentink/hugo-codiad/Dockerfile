FROM wernight/codiad
COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /code/workspace/hugo/public; \
  mkdir -p /etc/s6/hugo; \
  > /etc/s6/hugo/finish; \
  chmod +x /etc/s6/hugo/finish; \
  apk add --no-cache \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
  hugo; \
  apk add --no-cache git
COPY hugo.sh /etc/s6/hugo/run

VOLUME /code/workspace/hugo
