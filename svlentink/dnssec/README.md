# Bind as authorative DNS server with DNSSEC

Bind based on Alpine.

This container generates the DNSSEC config.
See [this docker-compose.yml](https://github.com/svlentink/dockerfiles/tree/master/svlentink/dnssec/docker-compose.yml) for the volumes and variables.

## About bind

Bind is the facto standard of DNS.
It is one three authorative DNS servers that run on the [root servers](https://en.wikipedia.org/wiki/Root_name_server).

In my opinion, the bad thing about bind is that it is a authorative and recursive server in one.
However, I use it since its config can also be loaded into [PowerDNS](https://doc.powerdns.com/authoritative/backends/index.html),
enabling one to migrate to a more advance solution when needed,
or to run two different DNS servers (more secure) with shared config.

You can find [here](https://linux.die.net/man/8/named) which parameters to provide
and [here](https://linux.die.net/man/5/named.conf) or [here](https://www.isc.org/downloads/bind/doc/) how to set up your config.


## files to mount
In `/zonefiles` you mount all your zone files
```
30.20.10.in-addr.arpa.zone #optional for reverse lookup
example.com.zone
delegated.another.tld.zone
```

## Based on
+ https://hub.docker.com/r/ventz/bind/~/dockerfile/
+ https://hub.docker.com/r/resystit/bind9/~/dockerfile/
+ https://hub.docker.com/r/os3nl/bind/~/dockerfile/

