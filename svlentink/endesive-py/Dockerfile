FROM python:slim

# install wget to get certificates and openssl to convert between formats
RUN apt update; \
  apt install -y python3-dev python3-pip swig wget openssl; \
  pip3 install requests cryptography asn1crypto Pillow lxml; \
  pip3 install endesive;
