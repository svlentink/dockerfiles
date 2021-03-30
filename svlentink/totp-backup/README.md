# totp-backup

For now, you can use this to backup your TOTP (2FA) tokens.

I personally enter the secret in this tool,
which then renders a QR code that I then scan with Google Authenticator.

This tool has its own CLI,
since people would otherwise enter the secret in the regular shell
and it would end up in history.

To run it:

```shell
touch /tmp/secrets.json
docker run -it --rm \
  -v /tmp:/storage \
  svlentink/totp-backup
```
## Example usage:

![example](https://github.com/svlentink/dockerfiles/raw/master/svlentink/totp-backup/example.png "example.png")


## Encrypt

You should
[encrypt](https://github.com/svlentink/password-generator/blob/master/crypt.sh)
your backup.

