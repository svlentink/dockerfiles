# Auto deploy

This systemd timer lets you auto deploy a newer build container from your container registry (e.g. Docker Hub).

## Installation

```shell
cp deploy-containers.timer   /etc/systemd/system/
cp deploy-containers.service /etc/systemd/system/
cp deploy-containers.sh      /usr/local/bin/
systemctl daemon-reload
systemctl enable deploy-containers.timer
systemctl start  deploy-containers.timer

```


