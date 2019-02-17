FROM node:6
ENV APPDIR /orion.client/modules/orionode
RUN git clone https://github.com/eclipse/orion.client.git /orion.client; \
  cd $APPDIR; \
  npm install;
WORKDIR $APPDIR
ENTRYPOINT ["/usr/local/bin/node"]
CMD ["server.js"]
