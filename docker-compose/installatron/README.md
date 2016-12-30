# Installatron docker compose

This compose launches two docker containers, the installatron and the DB.

+ `.env` holds environment variables for `docker-compose.yml`
+ the `db` service specified in `db.yml`, is used inside `docker-compose.yml`
+ the `Dockerfile` is used inside `docker-compose.yml` to build the container, you should specify the installatron key in this file
