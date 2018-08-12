FROM golang:alpine

RUN apk add --no-cache curl git tar

# https://caddyserver.com/download PERSONAL license!
ENV CADDYURL="https://caddyserver.com/download/linux/amd64?plugins=http.filemanager,http.git,http.hugo,http.realip&license=personal&telemetry=off"

RUN curl --silent --show-error --fail \
  -o - \
  $CADDYURL \
  | tar --no-same-owner -C /usr/bin/ -xz caddy; \
  chmod 0755 /usr/bin/caddy; \
  /usr/bin/caddy -version

# http://stackoverflow.com/questions/24987542/is-there-a-link-to-github-for-downloading-a-file-in-the-latest-release-of-a-repo
RUN GITHUB_REPO='filebrowser/filebrowser'; \
  apk add --no-cache curl; \
  LATEST_RELEASE_TAG=$(curl -Is https://github.com/${GITHUB_REPO}/releases/latest \
                         | grep Location | grep -oE '[0-9]+\.[0-9]+\.[0-9]+') || true; \
  echo using v${LATEST_RELEASE_TAG}; \
  curl --show-error --fail -L -o - \
  https://github.com/filebrowser/filebrowser/releases/download/v${LATEST_RELEASE_TAG}/linux-amd64-filebrowser.tar.gz \
  | tar --no-same-owner -C /usr/bin -xz filebrowser; \
  chmod 0755 /usr/bin/filebrowser

EXPOSE 80 2015
VOLUME /srv
WORKDIR /srv

#ADD https://raw.githubusercontent.com/ludovicc/caddy-hugo/master/caddy-hugo.sh /caddy-hugo.sh
#RUN chmod +x /caddy-hugo.sh

COPY caddy.conf /etc/Caddyfile

ENTRYPOINT ["/bin/sh"] #, "-c", "/usr/bin/filebrowser"]
#ENTRYPOINT ["/usr/bin/caddy"]
#CMD ["-conf", "/etc/Caddyfile"] #, "-disable-http-challenge","-disable-tls-sni-challenge","-agree"]
#ENTRYPOINT ["/caddy-hugo.sh"]
#CMD ["-conf", "/srv/Caddyfile", "-disable-http-challenge","-disable-tls-sni-challenge","-agree"]

