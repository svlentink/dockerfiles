# Filebrowser with Hugo plugin

Run it using:
```shell
docker run -it --rm \
  -p 8080:80 \
  -v $PWD:/srv \
  svlentink/filebrowser-hugo
```

## Quickstart
You can now visit `localhost:8080/admin` in your browser (login with admin admin).

The search bar (top left) allows you to run commands, such as
```shell
$ls /hugosite
```

### credits
The current Dockerfile is inspired by:
+ https://github.com/gohugoio/hugo/blob/master/Dockerfile
+ https://hub.docker.com/r/hacdias/filebrowser/~/dockerfile/
+ https://github.com/filebrowser/filebrowser/blob/master/build/build_assets.sh

Feel free to suggest and or leave a pull request.
