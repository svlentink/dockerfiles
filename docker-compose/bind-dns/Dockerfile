FROM alpine
RUN apk --no-cache add bind; mkdir -p /zonefiles
EXPOSE 53 53/udp
CMD ["named", "-c", "/etc/named.conf", "-g", "-u", "root"] # "named"]
COPY named.conf /etc/named.conf

