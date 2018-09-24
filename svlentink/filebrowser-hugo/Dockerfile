FROM golang:alpine AS builder

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
  cd /go/src/github.com/filebrowser/filebrowser/frontend; \
  yarn install; \
  yarn build; \
  cd /go/src/github.com/filebrowser/filebrowser; \
  dep ensure -vendor-only; \
  rice embed-go; \
  cd /go/src/github.com/filebrowser/filebrowser/cmd/filebrowser; \
  go build -a; \
  mv filebrowser /go/bin/filebrowser;

ENTRYPOINT ["/go/bin/filebrowser","--staticgen","hugo", "--config"]
CMD ["/go/src/github.com/filebrowser/filebrowser/Docker.json"]

FROM alpine

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /go/bin/filebrowser /
COPY --from=builder /go/bin/hugo /bin/hugo
RUN apk add --no-cache git

VOLUME /hugosite
EXPOSE 80

COPY filebrowser.yml /
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/filebrowser.yml"]
