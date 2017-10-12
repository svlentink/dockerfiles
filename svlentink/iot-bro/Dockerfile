FROM blacktop/bro

RUN apk add --no-cache python3
ADD https://raw.githubusercontent.com/elnappo/bro-log-parser/master/brologparse.py \
  /usr/lib/python3.6/brologparse.py
RUN chmod +x /usr/lib/python3.6/brologparse.py

# Volume statements to nothing, just like ports, they are a form of documentation
VOLUME /input # e.g. dump.pcap
VOLUME /output # directory in which we dump our results

#ENTRYPOINT ["/bin/sh","-c","bro -r /input && /main.py"]
ENTRYPOINT ["/docker-entrypoint.sh"]
COPY docker-entrypoint.sh /
COPY main.py /
