# Dell iDRAC

Firefox and Java, accessible through your browser.

Why? Because I want to be able to work on a Chromebook.
Dell iDRAC needs a Java Plugin to access the console of a server.

## Run it

Example of `docker-compose.yml`

```yaml
version: '3'
services:
  browser:
    build: svlentink/dell-idrac
    environment:
      - DISPLAY=novnc:0.0
    depends_on:
      - novnc
    networks:
      - x11
#    volumes:
#      - /etc/timezone:/etc/timezone:ro
  novnc:  
    image: psharkey/novnc
    environment:
      - DISPLAY_WIDTH=1200
      - DISPLAY_HEIGHT=900
    ports:
      - "8080:8080"
    networks:
      - x11
networks:
  x11:
```

When it is launched, go to
`http://localhost:8080/vnc_auto.html`

## IP

If you need specific IP ranges because docker is using the same internal range
(e.g. 172.x.x.x), have a look at
[this](http://serverfault.com/questions/774699/how-to-setup-an-ip-range-for-docker-containers)
link.

If your local machine uses a VPN to connect to your servers,
you'll need to specify a bridge, since docker won't use your VPN when running it localhost.
But running this container in your network is easier.
