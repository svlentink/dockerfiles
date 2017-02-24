# Dell iDRAC

Firefox and Java, accessible through your browser.

Why? Because I want to be able to work on a Chromebook.
Dell iDRAC needs a Java Plugin to access the console of a server.

## Run it

Example of `docker-compose.yml`

```yaml
version: '3'
services:
  main:
    svlentink/dell-idrac
    ports:
# 5901 = VNC client
# 80 = browser
      - "5901:5901"
      - "80:6901"
    environment:
      VNC_PW: 5ecr3tPwd

```

When it is launched, go to
`http://localhost:80/vnc_auto.html?password=5ecr3tPwd`

Note that this is not secure.
Only used it on an internal network.

## IP

If you need specific IP ranges because docker is using the same internal range
(e.g. 172.x.x.x), have a look at
[this](http://serverfault.com/questions/774699/how-to-setup-an-ip-range-for-docker-containers)
link.

If your local machine uses a VPN to connect to your servers,
you'll need to specify a bridge, since docker won't use your VPN when running it localhost.
But running this container in your network is easier.

## Base image

This container is base on
[psharkey/novnc](https://hub.docker.com/r/psharkey/novnc/)
but since
[one](https://github.com/psharkey/docker/blob/master/novnc/Dockerfile#L14)
line does not work anymore, I needed to rebuild it.
