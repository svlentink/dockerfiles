# totp-backup

in progress

```shell
touch /tmp/secrets.json
docker run -it --rm \
  -v /tmp:/storage \
  svlentink/totp-backup
```