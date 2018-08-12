FROM golang:alpine

#https://github.com/gohugoio/hugo/blob/master/Dockerfile
ENV CGO_ENABLED=0
ENV GOOS=linux

RUN apk --no-cache add \
  ca-certificates \
  musl-dev \
  git; \
  go get github.com/golang/dep/cmd/dep; \
  git clone https://github.com/filebrowser/filebrowser.git /go/src/github.com/filebrowser/filebrowser; \
  git clone https://github.com/filebrowser/frontend.git    /go/src/github.com/filebrowser/frontend; \
  ln -s /go/src/github.com/filebrowser/frontend /go/src/github.com/filebrowser/filebrowser/frontend; \
  git clone https://github.com/gohugoio/hugo.git /go/src/github.com/gohugoio/hugo/;

# https://github.com/filebrowser/filebrowser/blob/master/build/build_assets.sh
RUN apk --no-cache add yarn; \
  cd /go/src/github.com/filebrowser/frontend; \
  yarn install; yarn build
RUN rm -rf /go/src/github.com/filebrowser/filebrowser/frontend
RUN cp -a /go/src/github.com/filebrowser/frontend /go/src/github.com/filebrowser/filebrowser/frontend
RUN cd /go/src/github.com/filebrowser/filebrowser/; \
  go get github.com/GeertJohan/go.rice/rice; \
  rice embed-go

RUN cd /go/src/github.com/filebrowser/filebrowser; \
  dep ensure -vendor-only; \
  cd /go/src/github.com/filebrowser/filebrowser/cmd/filebrowser; \
  go build -a; \
  mv filebrowser /go/bin/filebrowser; \
  ln -s /go/bin/filebrowser /filebrowser

RUN cd /go/src/github.com/gohugoio/hugo; dep ensure -vendor-only; \
  cd /go/src/github.com/gohugoio/hugo; \
  go install -ldflags '-s -w'


VOLUME /tmp
VOLUME /srv
EXPOSE 80

ENTRYPOINT ["/filebrowser","--staticgen","hugo", "--config", "/go/src/github.com/filebrowser/filebrowser/Docker.json"]
ENTRYPOINT ["/bin/sh"]
