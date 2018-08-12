# IpFilter with basic auth (optional) and SSL

Used for getting things only quickly while developing.
Less secure than Iptables, but way faster when using docker.

See [this](https://github.com/svlentink/dockerfiles/blob/master/svlentink/ipfilter/docker-compose.yml) example.


## Production

Don't run this on your production env., it is fine for testing.
(this type of traffic filtering should be done on your host)

You can use the
[following](http://blog.viktorpetersson.com/post/101707677489/the-dangers-of-ufw-docker):
```shell
DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4 --iptables=false"
```

## alternative

Instead of IP filter, you can expand the barrier from network to device (just like beyondcorp):
https://github.com/bitly/oauth2_proxy
https://zero.pritunl.com

Or instead of this layer 4 (application layer),
you could use layer 3 filtering.
