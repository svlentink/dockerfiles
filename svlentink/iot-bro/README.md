STATUS: WIP, not working atm.

# IoT Bro

Analyse IoT network traffic with Bro and get a graphical representation of what is going on,
allowing an admin to make informed decicions when configuring a firewall.

## Usage

Use the
[docker-compose](https://github.com/svlentink/dockerfiles/blob/master/svlentink/iot-bro/docker-compose.yml)
file to run this app.

It should run for a minute,
after which you are able to view the results in a browser.

## Status

We currently developed this to be used as a process,
not as something you keep running and generates metrics in the background.
That would be better, but was too much work for our scope (PoC).

This tool is developed as part as our research for a course of os3.nl
