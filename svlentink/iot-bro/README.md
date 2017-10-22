# IoT Bro

Analyse IoT network traffic with Bro and get a graphical representation of what is going on,
allowing an admin to make informed decicions when configuring a firewall.

## Usage

#### Step 01

Get a tcpdump (`.pcap`).

We recommend to start collecting before turning your device on.
The initial DNS lookups will give meaning to the IP addresses it connects to.

#### Step 02

Use the
[docker-compose](https://github.com/svlentink/dockerfiles/blob/master/svlentink/iot-bro/docker-compose.yml)
file to run this app.

#### Step 03

Explore the data in your browser http://yourhost:8080

## Status

We currently developed this to be used as a process,
not as something you keep running and generates metrics in the background.
That would be better, but would be too much work for our scope (PoC).

This tool is developed as part as our research for a course of os3.nl

## Design

![design](draw_io.png 'edit this image on draw.io')

Bro can directly be used to gather data or load a file.
It outputs multiple log files (dependent on the configuration of Bro).

We then parse this data in `main.py`,
which is constructed generic, but configured to aim at IoT.
(You could tweak it do show very different results)

The output is send to the browser,
in which the data displayed in a basic tree structure.
Using d3js would be better but required too much time.
