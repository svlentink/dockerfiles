FROM python:slim

RUN apt update; \
  apt install -y python3-dev python3-pip swig wget curl openssl ca-certificates; \
  pip3 install requests cryptography asn1crypto Pillow lxml; \
  pip3 install endesive; \
  mkdir -p /example-certs; \
  cd /example-certs; \
  for i in `curl --silent https://cert.pkioverheid.nl/ | grep -o 'http.*\.cer'`; do \
    echo "$i"; \
	  wget --quiet "$i"; \
	  sleep 1; \
	done; \
	for i in `curl --silent https://certificaat.kpn.com/support/downloads/ | grep -o '/.*\.cer'`; do \
	  wget "https://certificaat.kpn.com$i"; \
	  sleep 1; \
	done; \
	echo Downloaded example certs; \
	for i in *.cer; do \
	  openssl x509 \
	    -inform der -in "$i" \
	    -outform pem -out "$i.pem"; \
	done;
