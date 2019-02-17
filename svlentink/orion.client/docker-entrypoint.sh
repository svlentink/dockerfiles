#!/bin/sh

ENTRYPOINT=/usr/local/bin/node
CMD=server.js

echo 'orion.site.virtualHosts='$VIRTUALHOSTS >> orion.conf
echo 'orion.proxy.port='$PUBLICPORT'\n' >> orion.conf

$ENTRYPOINT $CMD
