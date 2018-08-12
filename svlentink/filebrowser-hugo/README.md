# Filebrowser with Hugo plugin

The current Dockerfile is inspired by:
+ https://github.com/gohugoio/hugo/blob/master/Dockerfile
+ https://hub.docker.com/r/hacdias/filebrowser/~/dockerfile/
+ https://github.com/filebrowser/filebrowser/blob/master/build/build_assets.sh


We extended the [autobuild](https://hub.docker.com/r/hacdias/filebrowser/~/dockerfile/) filebrowser,
with the [Hugo](https://github.com/filebrowser/filebrowser/blob/master/caddy/hugo/hugo.go) plugin.

You can find a quick-start [here](https://filebrowser.github.io/quick-start/).

## links used during development
+ Inspiration, but outdated: https://hub.docker.com/r/ludovicc/caddy-hugo/~/dockerfile/
+ Installation guide: https://filebrowser.github.io/installation/#caddy

https://github.com/filebrowser/filebrowser/blob/master/cmd/filebrowser/main.go
https://github.com/filebrowser/filebrowser/issues/83
https://caddyserver.com/docs/http.hugo
