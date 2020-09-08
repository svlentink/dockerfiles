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


## TODO
I should put recommendations here about how to store the passwords.
So only use this tool if you know how to store your secrets.json file.

http://www.binarytides.com/create-password-protected-zip-archive-ubuntu/


