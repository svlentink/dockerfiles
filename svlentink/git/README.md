# Git

Everything can be dockerized, even git.
Why? Just because we can.
I do not use this anymore, but since no major Git updates are expected, you'll probably be fine with this.

```
docker run -it --rm \
  -v ~/.ssh:/root/.ssh \
  -v $(pwd):/git \
  svlentink/git \
  'your name' \
  commit -m 'your git command'
```
