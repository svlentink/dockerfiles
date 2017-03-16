IN PROGRESS, DOES NOT WORK ATM.

# IpFilter

IpFilter based on IPTABLES (alpine).

Since the default docker behavior is to
[change your iptables](http://blog.viktorpetersson.com/post/101707677489/the-dangers-of-ufw-docker),
we just fix it inside a docker container. (since editing host machines cannot be done in our `docker-compose.yml` file)

## Example usage

Firewall (this container) -> Nginx (some static website)

```yaml
version: '2'
services:
  firewall:
    privileged: true
    image: svlentink/ipfilter
    ports:
      - "8080:80"
    environment:
      - ALLOWED_IPS=127.0.0.1/30,8.8.8.8/32
#      - ALLOWED_TCP_PORTS=80 443
#      - ALLOWED_UDP_PORTS=123
    networks:
      - shared
  cdn:
    image: nginx:alpine
    volumes:
      - $PWD:/usr/share/nginx/html:ro
    links:
      - firewall
    networks:
      - shared
    expose:
      - 80
networks:
  shared:

```

## Production

Don't run this on your production env., it is fine for testing.
(this type of traffic filtering should be done on your host)

You can use the
[following](http://blog.viktorpetersson.com/post/101707677489/the-dangers-of-ufw-docker):
```shell
DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4 --iptables=false"
```
