FROM node:6
ENV APPDIR /orion.client/modules/orionode
RUN git clone https://github.com/eclipse/orion.client.git /orion.client; \
  cd $APPDIR; \
  npm install;
WORKDIR $APPDIR
ENV PUBLICPORT 8081 # the port your browser will see (is different behind proxy)
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
