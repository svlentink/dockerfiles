#!/bin/sh

if ! ls /hugosite/config.*; then
  echo 'No config found at /hugosite/config.*, creating new examplesite'
  # https://gohugo.io/getting-started/quick-start
  cd /tmp
  hugo new site examplesite
  mv /tmp/examplesite/* /hugosite/
  cd /hugosite
  git init
  git submodule add https://github.com/budparr/gohugo-theme-ananke.git themes/ananke
  echo 'theme = "ananke"' >> config.toml
  hugo new posts/my-first-post.md
  echo created website, now building it
  hugo
fi

hugo --watch
