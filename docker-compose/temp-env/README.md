# temp-env

As the name suggests, a docker-compose for creating a temp. environment.
I use this when I know that I'll be in a place, where I can't use my own machine.

T
## Step01
I'll spin up a new instance on a [VPS provider](https://scaleway.com), select docker as image and smallest VPS (64bit).

## Step02
I `ssh` into the machine and run your basics (e.g. `apt install ufw`, update etc.).

## Step03
Run this script
```shell
curl -sSL \
  https://raw.githubusercontent.com/svlentink/dockerfiles/master/docker-compose/temp-env/script.sh \
  | sh
```

open in browser:
`https://IP_OF_VPS:163`
