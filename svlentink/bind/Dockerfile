FROM alpine
RUN apk add --no-cache bind
EXPOSE 53
EXPOSE 53/udp
VOLUME /etc/bind
ENTRYPOINT ["named","-f"]
