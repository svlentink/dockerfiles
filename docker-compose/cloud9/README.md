# Cloud9

This browser base IDE is launched on port [163](localhost:163) (IdE).

I use it to quickly launch a workable environment on a (new) laptop.
It provides you with a terminal, which has Git installed.

### config

This compose file mounts the `~/.ssh` directory and the `~/.gitconfig` file.
If you do not have a config file yet, docker will make it appear as a directory instead of a file.

If you are asked to configure a git user, do something like;
```bash
docker-compose kill \
&& docker-compose rm && \
cat <<'EOF' > ~/.gitconfig
[user]
    email = user@domain.tld
    name = username
[push]
    default = simple
EOF
```
