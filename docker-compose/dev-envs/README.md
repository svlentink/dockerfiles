# Developer environments

This scripts spins up multiple developer instances,
available at an URL.

## Requirements

- `docker`
- `docker-compose`
- file with usernames and hashed passwords

### usernames file

You are required to create your own logic for creating passwords for users.
An example has been given in `get_users_from_getent_example.sh`.

We need a file containing the following format:
```
user1:PASSWORD_HASH:optional_comment
user2:$apr1$QdR8fNLT$vbCEEzDj7LyqCMyNpSoBh/
user3:$apr1$Mr5A0e.U$0j39Hp5FfxRkneklXaMrr/
```
this hash is generated using openssl,
see
[this](https://github.com/svlentink/dockerfiles/blob/5c7bdb889d735cfb6cad17ae9a319e26fca5c4c2/svlentink/ipfilter/docker-entrypoint.sh#L62:L63)
example.

You can read more
[here](https://docs.nginx.com/nginx/admin-guide/security-controls/configuring-http-basic-authentication/).

