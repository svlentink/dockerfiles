FROM kdelfour/cloud9-docker

RUN npm install --global gitbook-cli \
  && gitbook fetch latest \
  && npm cache clear \
  && rm -rf /tmp/*

