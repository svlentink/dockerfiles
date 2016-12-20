# Git

Everything can be dockerized, even git.
Why? Just because we can.
See my other repo. [MacHacks](http://github.com/svlentink/machacks) on how it could be useful.

```
docker run -it --rm \
  -v ~/.ssh:/root/.ssh \
  -v $(pwd):/git \
  svlentink/git \
  'your name' \
  commit -m 'your git command'
```

