FROM golang:alpine AS builder

#https://github.com/gohugoio/hugo/blob/master/Dockerfile
ENV CGO_ENABLED=0
ENV GOOS=linux

RUN apk --no-cache add \
  ca-certificates \
  git \
  musl-dev \
  yarn;

RUN go get github.com/golang/dep/cmd/dep
RUN go get github.com/GeertJohan/go.rice/rice
RUN git clone https://github.com/filebrowser/filebrowser.git /go/src/github.com/filebrowser/filebrowser
RUN git clone https://github.com/filebrowser/frontend.git    /go/src/github.com/filebrowser/filebrowser/frontend
RUN git clone https://github.com/gohugoio/hugo.git           /go/src/github.com/gohugoio/hugo/

ENV GO111MODULE=on
WORKDIR /go/src/github.com/gohugoio/hugo
RUN go mod vendor
#RUN dep ensure -vendor-only
RUN go install -ldflags '-s -w'

WORKDIR /go/src/github.com/filebrowser/filebrowser/frontend
RUN yarn install; \
  yarn build;

WORKDIR /go/src/github.com/filebrowser/filebrowser/cli
RUN go mod vendor
RUN go install #-ldflags '-s -w'
RUN rice embed-go

WORKDIR /go/src/github.com/filebrowser/filebrowser/cmd/filebrowser
RUN go build -a
RUN mv filebrowser /go/bin/filebrowser

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
