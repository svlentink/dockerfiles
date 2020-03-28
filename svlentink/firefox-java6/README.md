# Dell iDRAC

Firefox and Java, accessible through your browser.

Why? Because I want to be able to work on a Chromebook.
Dell iDRAC needs a Java Plugin to access the console of a server.
(last optimized on 6sep17, to use with the version at the SNE lab)

## Run it

Run [this](https://github.com/svlentink/dockerfiles/blob/master/svlentink/firefox-java6/docker-compose.yml),
When it is launched, go to
`http://localhost:8080/vnc_auto.html`

## IP

If you need specific IP ranges because docker is using the same internal range
(e.g. 172.x.x.x), have a look at
[this](http://serverfault.com/questions/774699/how-to-setup-an-ip-range-for-docker-containers)
and
[this](http://serverfault.com/questions/771108/allow-docker-containers-to-use-ipsec-vpn-on-host)
or
[this](https://github.com/jessfraz/dockerfiles/tree/master/openvpn)
link.

If your local machine uses a VPN to connect to your servers,
you'll need to specify a bridge, since docker won't use your VPN when running it localhost.
But running this container in your network is easier.

## Bootable ISO

When installing a new OS, you can use an ISO.
First download it to your machine (place it in `/tmp` or edit reference below)
and add the following line to both `services` in your `docker-compose.yml`:

```yaml
    volumes:
      - /tmp/debian.iso:/debian.iso
```

We want to have it mounted on both at the same location, since this will make the reference the same.

Now you can
+ Open NOVNC in your browser and type the IP of your IDRAC interface in the firefox URL bar.
+ Accept and add exceptions for all future warnings
+ Log in, default = root/calvin
+ Open `Virtual Console` -> `Launch Virtual Console`
+ Enter your bios (you may `Power` -> `Reset System (warm boot)`) and configure your (IDRAC) network (e.g. DHCP) and [disk configuration](http://serverfault.com/questions/413504/dell-poweredge-1950-how-use-raw-disk-instead-hardware-raid-perc-5-i)
+ In the upper bar: `Virtual Media` -> `Connect Virtual Media`
+ `Virtual Media` -> `Map CD/DVD`
+ Select your ISO, which will be at `/debian.iso`
+ `Next Boot` -> `Virtual CD/DVD/ISO`
+ warm reboot
+ Your installer will now launch


## TODO

See if the following is a good alternative: guacamole.apache.org

