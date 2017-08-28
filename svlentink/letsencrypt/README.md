# Letsencrypt

JSON output of certbot

```shell
docker-compose up | grep '{cert:['
```
just look at the example
[docker-compose.yml](https://github.com/svlentink/dockerfiles/blob/master/svlentink/letsencrypt/docker-compose.yml)

## Using it with Nginx

```
listen 443 ssl;
ssl_certificate         /etc/letsencrypt/live/example.com/cert.pem;
ssl_certificate_key     /etc/letsencrypt/live/example.com/privkey.pem;
ssl_trusted_certificate /etc/letsencrypt/live/example.com/chain.pem;
```

## Known limitations

If you want to request a certificate for a very long name,
you need a second domain,
in order to be able to set the CommonName.

When you automate this into your routine,
you should account for this!

E.g. `this-part-of-domain-can-be-63chars-which-brings-the-total-to-70.online`
can only be registered with the help of a shorter domain.
