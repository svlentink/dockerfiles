FROM python:alpine

ENV CTMPL_VERSION 0.19.5

RUN apk add --no-cache wget unzip && cd /tmp && \
  wget https://releases.hashicorp.com/consul-template/${CTMPL_VERSION}/consul-template_${CTMPL_VERSION}_linux_amd64.zip && \
  unzip consul-template_${CTMPL_VERSION}_linux_amd64.zip && \
  chmod +x consul-template && \
  mv consul-template /usr/local/bin && \
  rm consul-template_${CTMPL_VERSION}_linux_amd64.zip && \
  apk del wget unzip
