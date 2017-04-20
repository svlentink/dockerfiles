# Letsencrypt

JSON output of certbot

```shell
docker-compose up | grep '{cert:['
```
just look at the example
[`docker-compose.yml`](https://github.com/svlentink/dockerfiles/blob/master/svlentink/letsencrypt/docker-compose.yml)


## Example output

The certificate files are converted to arrays with strings, the lines of the file.

```shell
ssl_1  | domains found: ssltest.inbetweencows.nl
ssl_1  | Saving debug log to /var/log/letsencrypt/letsencrypt.log
ssl_1  | Obtaining a new certificate
ssl_1  | Performing the following challenges:
ssl_1  | http-01 challenge for ssltest.inbetweencows.nl
ssl_1  | Waiting for verification...
cdn_1  | 66.133.109.36 - - [19/Apr/2017:14:27:17 +0000] "GET /.well-known/acme-challenge/Dd5fvRwW-OnOKLg6--yhFsFj-dgQ-Z6Wp7IgO5DGKbI HTTP/1.1" 200 88 "-" "Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org)" "-"
ssl_1  | Cleaning up challenges
ssl_1  | Generating key (2048 bits): /etc/letsencrypt/keys/0000_key-certbot.pem
ssl_1  | Creating CSR: /etc/letsencrypt/csr/0000_csr-certbot.pem
ssl_1  | IMPORTANT NOTES:
ssl_1  |  - Congratulations! Your certificate and chain have been saved at
ssl_1  |    /etc/letsencrypt/live/ssltest.inbetweencows.nl/fullchain.pem. Your
ssl_1  |    cert will expire on 2017-07-18. To obtain a new or tweaked version
ssl_1  |    of this certificate in the future, simply run certbot again. To
ssl_1  |    non-interactively renew *all* of your certificates, run "certbot
ssl_1  |    renew"
ssl_1  |  - Your account credentials have been saved in your Certbot
ssl_1  |    configuration directory at /etc/letsencrypt. You should make a
ssl_1  |    secure backup of this folder now. This configuration directory will
ssl_1  |    also contain certificates and private keys obtained by Certbot so
ssl_1  |    making regular backups of this folder is ideal.
ssl_1  |  - If you like Certbot, please consider supporting our work by:
ssl_1  | 
ssl_1  |    Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
ssl_1  |    Donating to EFF:                    https://eff.org/donate-le
ssl_1  | 
ssl_1  | ### BEGIN JSON ###
ssl_1  | {cert:["-----BEGIN CERTIFICATE-----","MIIFFDCCA/ygAwIBAgISA68ljLooGPUPL8cXa+HnnD+XMA0GCSqGSIb3DQEBCwUA","MEoxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MSMwIQYDVQQD","ExpMZXQncyBFbmNyeXB0IEF1dGhvcml0eSBYMzAeFw0xNzA0MTkxMzI3MDBaFw0x","NzA3MTgxMzI3MDBaMCMxITAfBgNVBAMTGHNzbHRlc3QuaW5iZXR3ZWVuY293cy5u","bDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMclQH/c6aoCN569Z/BR","YbObYCC79sYjl1Q3PVGF7j2i9hjnBsh2Prrhd24aDcl1gOmUPINuTFk764G2zH7d","JhVjChLE6waDHlu+w/4yrtyGWaVCsa01OBKU1K3YOINAVVV6CGY6UobMTARMVD1U","QE5Uj86XeHIeKb5uNf1YCS0jpt4KbR2V6+Tr1kcC1XWax3O3ZRN4887zpM+DB/vL","cQbkIJRAql1UTEoiEpE7w1WCJRU9YMle/F6s6mmh8n37mj8BR4pTGKHXNw43Z/SG","m/Q2ZJBPkWwls3aCbsagSCtAWrYltQyiuNd7i91acwY1pd6dRAjdzLBQriYYm0yG","HWECAwEAAaOCAhkwggIVMA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEF","BQcDAQYIKwYBBQUHAwIwDAYDVR0TAQH/BAIwADAdBgNVHQ4EFgQUh9/wonFFFUwf","EzzF2KgkpXdLe4owHwYDVR0jBBgwFoAUqEpqYwR93brm0Tm3pkVl7/Oo7KEwcAYI","KwYBBQUHAQEEZDBiMC8GCCsGAQUFBzABhiNodHRwOi8vb2NzcC5pbnQteDMubGV0","c2VuY3J5cHQub3JnLzAvBggrBgEFBQcwAoYjaHR0cDovL2NlcnQuaW50LXgzLmxl","dHNlbmNyeXB0Lm9yZy8wIwYDVR0RBBwwGoIYc3NsdGVzdC5pbmJldHdlZW5jb3dz","Lm5sMIH+BgNVHSAEgfYwgfMwCAYGZ4EMAQIBMIHmBgsrBgEEAYLfEwEBATCB1jAm","BggrBgEFBQcCARYaaHR0cDovL2Nwcy5sZXRzZW5jcnlwdC5vcmcwgasGCCsGAQUF","BwICMIGeDIGbVGhpcyBDZXJ0aWZpY2F0ZSBtYXkgb25seSBiZSByZWxpZWQgdXBv","biBieSBSZWx5aW5nIFBhcnRpZXMgYW5kIG9ubHkgaW4gYWNjb3JkYW5jZSB3aXRo","IHRoZSBDZXJ0aWZpY2F0ZSBQb2xpY3kgZm91bmQgYXQgaHR0cHM6Ly9sZXRzZW5j","cnlwdC5vcmcvcmVwb3NpdG9yeS8wDQYJKoZIhvcNAQELBQADggEBACHyjD6HFTEB","J5rHS7CKsZMWJ75Qz9OQznnglFbUJ5G3HKFt7q1GwWJjF9HsG2F47jnzUPlMFtxI","FBqtxR5lZqNTJW0CvEREXlr+xnp/jjY43wKa5Yfr6ALog3m6Mm/7DMVcujVZ5ucj","7A33cVfm4WXoVHbUeNZo7BRBUvpoRWmYHlh/g1mPjdaL5CgMQ3CkwCgOK74Ir7Bi","RoVSFTqhKm1WM0SMpDSO1okH+BelGX1yvv26ssT8mJeq+QmROV+W87n+FXGlxlf2","TRwIUim9KINTxqY2f9M0ytlQiNJH81t359crhkieV9T1Lt2i7lvNB+shcBTX/OWO","6vCW7N/s+S8=","-----END CERTIFICATE-----"],key:["-----BEGIN PRIVATE KEY-----","MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDHJUB/3OmqAjee","vWfwUWGzm2Agu/bGI5dUNz1Rhe49ovYY5wbIdj664XduGg3JdYDplDyDbkxZO+uB","tsx+3SYVYwoSxOsGgx5bvsP+Mq7chlmlQrGtNTgSlNSt2DiDQFVVeghmOlKGzEwE","TFQ9VEBOVI/Ol3hyHim+bjX9WAktI6beCm0dlevk69ZHAtV1msdzt2UTePPO86TP","gwf7y3EG5CCUQKpdVExKIhKRO8NVgiUVPWDJXvxerOppofJ9+5o/AUeKUxih1zcO","N2f0hpv0NmSQT5FsJbN2gm7GoEgrQFq2JbUMorjXe4vdWnMGNaXenUQI3cywUK4m","GJtMhh1hAgMBAAECggEAJ5EKMJ1Wu5V3MY3WQdQZglLjlX1i+VkG7w+Omkzu2cYv","+SClo1yC+CRl0zVP+e/jrgTqxP48IxqZnwsPtEECGQu1a6c+Puv8MyRC0pWFUoFK","/F+054IEYwS5ANVN3R4CFlqJoq4ByZB7pfr4XbsIj8eTTuufXaUKjDBff7dnE1WB","T5JpZ0IfuHNJouFChwkAfG+SrQj929dXhsyn1iLGraE+ZzdudhwQ0LlgbHSg3JeE","LYtYH+Lbrv0LsqOqJT9ysWXXkeSD/Ybvqu6Lv6LGnObDoKk2z3lob4LGtXj0wC1Z","/QmjQDqZQUboO4OBA8fjVqCvwF80ZtVkTJJq7LOXdQKBgQDjPwIw9Jcv30in8h45","4lxIzLPkf7hUdiJ1PYGU4LumMRyHA5uAZCJQn4WjkHUFtCYS3j73+6ldaHOnyMdK","k3Px4CiM7POd8jzywNLtSjiq4d3XxEQhY1jdLkrSE2lf2wPg6EpDQTuCvx8eafkH","M8Mx21mnZHZ0h3knotR9MBdHRwKBgQDgWAEKK3tI0c/jKoHEIQuVVQIkuxR/FldD","dsq4yWtGyW80lFMvkOfEFxgdfmL1DI+qOp7nqyWEgHFRk5iFpkbHb+vM4nVdHZrV","SCOQ+fVszUVe3JUSZbYrkjcizL2O5QZ3C0Oy36MHYlcrDHuAFiPoLUIwWcry/FCX","rVhgvQKaFwKBgC7bCg+gDyBe0LNYV+UliFO2aY0+zHoV1asI4JQa9nYhADnSg5io","jO7ExaBhI8/mQkd3rdIiANzysY4x9u2ok6qWxqWwIdc6YFjJa3Rj7mVFpyFbJZUg","z+zjI6hHOl36YcVZAB7371ZZJAh4X1Gd2ayJBuZd75K9cDy89UVOyi33AoGAJ9M3","jAigABNO5jK7ioebOM04bjDPuKfMoetKnXcUFiLYHOtfwQfmPMckvsea5YlvT3bM","kq+tH1J1y1d6Me+MjQbvQxXIY9lHjSkbNzdIPCJMeESMKhHoPt/b7c+Orvk1JpjX","Ub+lf0AT3U5/9gL4KNUv9Mlb37quy9433CRxe80CgYEAxVHBacN+1MijomWjSBLT","d9fJAoBAQ7vS4Z3Wpmca8L+BQTtKXJUSoTNRdmlBdUUULQMf1cyCSbFkNl3sPsZX","nczTLPdroukJHUXT618Ikb2vIGlUw57UPZwSNIavHIlcpVi8ZuWmTsAWgUjOX1vP","3SzhXElnTQYWOOYn3f0aHRM=","-----END PRIVATE KEY-----"],chain:["-----BEGIN CERTIFICATE-----","MIIEkjCCA3qgAwIBAgIQCgFBQgAAAVOFc2oLheynCDANBgkqhkiG9w0BAQsFADA/","MSQwIgYDVQQKExtEaWdpdGFsIFNpZ25hdHVyZSBUcnVzdCBDby4xFzAVBgNVBAMT","DkRTVCBSb290IENBIFgzMB4XDTE2MDMxNzE2NDA0NloXDTIxMDMxNzE2NDA0Nlow","SjELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUxldCdzIEVuY3J5cHQxIzAhBgNVBAMT","GkxldCdzIEVuY3J5cHQgQXV0aG9yaXR5IFgzMIIBIjANBgkqhkiG9w0BAQEFAAOC","AQ8AMIIBCgKCAQEAnNMM8FrlLke3cl03g7NoYzDq1zUmGSXhvb418XCSL7e4S0EF","q6meNQhY7LEqxGiHC6PjdeTm86dicbp5gWAf15Gan/PQeGdxyGkOlZHP/uaZ6WA8","SMx+yk13EiSdRxta67nsHjcAHJyse6cF6s5K671B5TaYucv9bTyWaN8jKkKQDIZ0","Z8h/pZq4UmEUEz9l6YKHy9v6Dlb2honzhT+Xhq+w3Brvaw2VFn3EK6BlspkENnWA","a6xK8xuQSXgvopZPKiAlKQTGdMDQMc2PMTiVFrqoM7hD8bEfwzB/onkxEz0tNvjj","/PIzark5McWvxI0NHWQWM6r6hCm21AvA2H3DkwIDAQABo4IBfTCCAXkwEgYDVR0T","AQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwfwYIKwYBBQUHAQEEczBxMDIG","CCsGAQUFBzABhiZodHRwOi8vaXNyZy50cnVzdGlkLm9jc3AuaWRlbnRydXN0LmNv","bTA7BggrBgEFBQcwAoYvaHR0cDovL2FwcHMuaWRlbnRydXN0LmNvbS9yb290cy9k","c3Ryb290Y2F4My5wN2MwHwYDVR0jBBgwFoAUxKexpHsscfrb4UuQdf/EFWCFiRAw","VAYDVR0gBE0wSzAIBgZngQwBAgEwPwYLKwYBBAGC3xMBAQEwMDAuBggrBgEFBQcC","ARYiaHR0cDovL2Nwcy5yb290LXgxLmxldHNlbmNyeXB0Lm9yZzA8BgNVHR8ENTAz","MDGgL6AthitodHRwOi8vY3JsLmlkZW50cnVzdC5jb20vRFNUUk9PVENBWDNDUkwu","Y3JsMB0GA1UdDgQWBBSoSmpjBH3duubRObemRWXv86jsoTANBgkqhkiG9w0BAQsF","AAOCAQEA3TPXEfNjWDjdGBX7CVW+dla5cEilaUcne8IkCJLxWh9KEik3JHRRHGJo","uM2VcGfl96S8TihRzZvoroed6ti6WqEBmtzw3Wodatg+VyOeph4EYpr/1wXKtx8/","wApIvJSwtmVi4MFU5aMqrSDE6ea73Mj2tcMyo5jMd6jmeWUHK8so/joWUoHOUgwu","X4Po1QYz+3dszkDqMp4fklxBwXRsW10KXzPMTZ+sOPAveyxindmjkW8lGy+QsRlG","PfZ+G6Z6h7mjem0Y+iWlkYcV4PIWL1iwBi8saCbGS5jN2p8M+X+Q7UNKEkROb3N6","KOqkqm57TH2H3eDJAkSnh6/DNFu0Qg==","-----END CERTIFICATE-----"]}
```

You could `grep` on "`{cert:[`" and "will expire on"
(to avoid different line breaks,
you should use `[0-9]{4}-[0-9]{2}-[0-9]{2}\.`)


## Using it with Nginx

```
listen 443 ssl;
ssl_certificate         /etc/letsencrypt/live/example.com/cert.pem;
ssl_certificate_key     /etc/letsencrypt/live/example.com/privkey.pem;
ssl_trusted_certificate /etc/letsencrypt/live/example.com/chain.pem;
```
