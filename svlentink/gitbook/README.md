# Gitbook

Why? Because there was no minimal gitbook docker image that was up-to-date.


Example of `docker-compose.yml`
```shell
# Run this file with 'docker-compose up [init|build|run]'
version: '2'
services:
  gitbook:
    image: svlentink/gitbook
    volumes:
      - ~/:/gitbook
  init:
    extends: gitbook
    command: init
  build:
    extends: gitbook
    command: build
  serve:
    extends: gitbook
    command: serve
    ports:
      - "35729:35729"

```
