FROM hashicorp/terraform:light
ENTRYPOINT ["/docker-entrypoint.sh"]
RUN apk add --no-cache py3-pip \
  && pip3 install typing icalevents
COPY . /

