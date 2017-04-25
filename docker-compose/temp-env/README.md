# temp-env

As the name suggests, a docker-compose for creating a temp. environment.
I use this when I know that I'll be in a place, where I can't use my own machine.

TODO
The current version is based on an old docker container
[this](https://hub.docker.com/r/sapk/cloud9/)
one has auth build in!
This will remove step 03 and 04, just the docker-compose needs to be updated.

## Step01
I'll spin up a new instance on a [VPS provider](https://scaleway.com), select docker as image and smallest VPS (64bit).

## Step02
I `ssh` into the machine and run a basic script (e.g. `apt install ufw`, update etc.).

## Step03
Clone this repo.
```shell
cd && git clone https://github.com/svlentink/dockerfiles.git
```

## Step04
Create login credentials
```shell
docker run -it --rm m31271n/htpasswd <username> <password> \
  >> ~/dockerfiles/docker-compose/temp-env/htpasswd
```

## Step05
Launch

```shell
docker-compose up -d
```

## Step06
On local machine (i.e. laptop), open in browser:
`http://IP_OF_VPS:163`

## Optionally

You can also add the `auth_basic` lines to the static part.
