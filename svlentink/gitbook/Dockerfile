FROM node:alpine

RUN npm install --global gitbook-cli \
  && gitbook fetch latest \
  && npm cache clear --force \
  && rm -rf /tmp/*

WORKDIR /gitbook
VOLUME /gitbook

ENTRYPOINT ["/usr/local/bin/gitbook"]
# default entry point
# other options could be build or serve
CMD ["init"]
