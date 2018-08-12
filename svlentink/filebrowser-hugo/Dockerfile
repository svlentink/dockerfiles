FROM golang:alpine

#https://github.com/gohugoio/hugo/blob/master/Dockerfile
ENV CGO_ENABLED=0
ENV GOOS=linux

RUN apk --no-cache add \
  ca-certificates \
  git \
  musl-dev \
  yarn; \
  go get github.com/golang/dep/cmd/dep; \
  go get github.com/GeertJohan/go.rice/rice; \
  git clone https://github.com/filebrowser/filebrowser.git /go/src/github.com/filebrowser/filebrowser; \
  git clone https://github.com/filebrowser/frontend.git    /go/src/github.com/filebrowser/filebrowser/frontend; \
  git clone https://github.com/gohugoio/hugo.git           /go/src/github.com/gohugoio/hugo/; \
  cd /go/src/github.com/gohugoio/hugo; \
  dep ensure -vendor-only; \
  go install -ldflags '-s -w'; \
  ln -s /go/bin/hugo /hugo; \
  cd /go/src/github.com/filebrowser/filebrowser/frontend; \
  yarn install; \
  yarn build; \
  cd /go/src/github.com/filebrowser/filebrowser; \
  dep ensure -vendor-only; \
  rice embed-go; \
  cd /go/src/github.com/filebrowser/filebrowser/cmd/filebrowser; \
  go build -a; \
  mv filebrowser /go/bin/filebrowser; \
  ln -s /go/bin/filebrowser /filebrowser;

VOLUME /tmp
VOLUME /srv
EXPOSE 80

ENTRYPOINT ["/filebrowser","--staticgen","hugo", "--config", "/go/src/github.com/filebrowser/filebrowser/Docker.json"]
ENTRYPOINT ["/bin/sh"]
