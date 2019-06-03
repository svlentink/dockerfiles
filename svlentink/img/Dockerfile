FROM alpine
RUN apk add --no-cache git; \
  apk add img --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing
VOLUME /build-context
WORKDIR /build-context
ENTRYPOINT ["img", "build", "-t", "test"]
CMD ["."]
