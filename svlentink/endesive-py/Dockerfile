FROM python:slim

RUN apt update; \
  apt install -y python3-dev python3-pip swig wget curl openssl; \
  pip3 install requests cryptography asn1crypto Pillow lxml; \
  pip3 install endesive; \
  mkdir -p /example-certs; \
  cd /example-certs; \
  for i in `curl --silent https://cert.pkioverheid.nl/ | grep -o 'http.*\.cer'`; do \
	  wget $i; \
	  sleep 1; \
	done; \
	for i in `ls *.cer`; do \
	  openssl x509 \
	    -inform der -in $i \
	    -outform pem -out $i.pem; \
	done;
