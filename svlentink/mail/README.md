# mail

Send mail by running this container

```bash
to=$(git config user.email) \
&& from=from@example.com \
&& subj='lorem ipsum' \
&& docker run --rm -it svlentink/mail $to $from "$subj" and this is the body
```