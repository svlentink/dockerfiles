#!/bin/sh

if ! ls /code/workspace/hugo/config.*; then
  echo 'No config found at /code/workspace/hugo/config.*, creating new examplesite'
  # https://gohugo.io/getting-started/quick-start
  cd /tmp
  hugo new site examplesite
  mv /tmp/examplesite/* /code/workspace/hugo
  cd /code/workspace/hugo
  git init
  git submodule add https://github.com/budparr/gohugo-theme-ananke.git themes/ananke
  echo 'theme = "ananke"' >> config.toml
  hugo new posts/my-first-post.md
  echo created website, now building it
  hugo
fi

hugo --watch
