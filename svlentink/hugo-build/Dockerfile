FROM alpine
ARG THEMES='https://github.com/svlentink/hugo-youtube-blog https://github.com/ribice/kiss https://github.com/fredrikloch/hugoscroll'
RUN apk add --no-cache tar gzip git curl; \
  curl --location -o /tmp/hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v0.57.2/hugo_0.57.2_Linux-64bit.tar.gz; \
  cd /tmp; \
  tar xvfz hugo.tar.gz; \
  rm hugo.tar.gz; \
  mv /tmp/hugo /usr/local/bin/; \
  mkdir -p /etc/hugo/themes; \
  cd /etc/hugo/themes; \
  for repo in $THEMES; do git clone $repo; done;  
