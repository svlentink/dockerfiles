# mail

[![](https://images.microbadger.com/badges/image/svlentink/mail.svg)](https://microbadger.com/images/svlentink/mail "Get your own image badge on microbadger.com")

Send mail by running this container.
You can pass the body with the container as a command or mount a volume (body file).

Example of `docker-compose.yml`
```yaml
version: '3'
services:
  main:
    image: svlentink/mail
    volumes:
      - /tmp/my_email_body.txt:/body:ro
    environment:
      - TO_ADDR=to@addr.ess
      - FROM_NAME=Alpha Beta
      - FROM_ADDR=from@addr.ess
      - SUBJ=subject line
#    command: body context here, only when the body volume is not mounted
```
