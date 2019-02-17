FROM node:6 #-alpine
ENV APPDIR /orion.client/modules/orionode
#RUN apk add --no-cache git; \
RUN git clone https://github.com/eclipse/orion.client.git /orion.client; \
  cd $APPDIR; \
  npm install;
WORKDIR $APPDIR
CMD server.js

